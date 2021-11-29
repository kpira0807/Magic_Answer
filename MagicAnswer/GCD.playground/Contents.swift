import Cocoa

// Homework 6 for Yalantis School
// Task 1: Deadlock with two queues

func deadlockExampleFirst() {
    // create two serial queue (последовательные очереди)
    let firstClient = DispatchQueue(label: "firstClient")
    let secondClient = DispatchQueue(label: "secondClient")
    
    // sync queue
    firstClient.sync {
        print("First Client: Please, give me your folk")

        secondClient.sync {
            print("Second Client: No problem, but firstly give me please your knife")
        
            firstClient.sync {
                print("First Client: Sure! Take please!")
                print("First Second: Sure! Take please!")
            }
        }
    }
}

deadlockExampleFirst()

// Another example for deadlock

func deadlockExampleSecond() {
    
    let firstSerialQueue = DispatchQueue(label: "com.gcd.firstQueue")
    let secondSerialQueue = DispatchQueue(label: "com.gcd.secondQueue")
    
    firstSerialQueue.setTarget(queue: secondSerialQueue)
    secondSerialQueue.setTarget(queue: firstSerialQueue)
    
    [firstSerialQueue, secondSerialQueue].forEach {$0.activate()}
    
    firstSerialQueue.async {
        print("Done")
    }
}

deadlockExampleSecond()

// Task 2: Cancellation of DispatchWorkItem - create background queue, create DispatchWorkItem with infinite print(“0”) logic (use “while true” cycle). Schedule asynchronously item on queue and then cancel it after 2 seconds (use async after).

func Cancellation() {
    var dispatchWorkItem: DispatchWorkItem!
    
    dispatchWorkItem = DispatchWorkItem {
        while true {
            if dispatchWorkItem.isCancelled { break }
            print("0")
        }
    }
    
    DispatchQueue.main.async(execute: dispatchWorkItem)
    DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak dispatchWorkItem] in
        dispatchWorkItem?.cancel()
        print("Cancellation")
    }
}

Cancellation()


