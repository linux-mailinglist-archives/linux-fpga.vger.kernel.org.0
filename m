Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8393CD9610
	for <lists+linux-fpga@lfdr.de>; Wed, 16 Oct 2019 17:55:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405870AbfJPPzJ (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 16 Oct 2019 11:55:09 -0400
Received: from mga12.intel.com ([192.55.52.136]:39533 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405860AbfJPPzJ (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 16 Oct 2019 11:55:09 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Oct 2019 08:55:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,304,1566889200"; 
   d="scan'208";a="370837343"
Received: from tthayer-hp-z620.an.intel.com (HELO [10.122.105.146]) ([10.122.105.146])
  by orsmga005.jf.intel.com with ESMTP; 16 Oct 2019 08:55:06 -0700
Reply-To: thor.thayer@linux.intel.com
Subject: Re: [PATCH v4 1/2] fpga: fpga-mgr: Add readback support
To:     Moritz Fischer <mdf@kernel.org>
Cc:     Appana Durga Kedareswara Rao <appanad@xilinx.com>,
        Alan Tull <atull@kernel.org>,
        Michal Simek <michals@xilinx.com>,
        "kedare06@gmail.com" <kedare06@gmail.com>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Nava kishore Manne <navam@xilinx.com>,
        Siva Durga Prasad Paladugu <sivadur@xilinx.com>,
        Richard Gong <richard.gong@linux.intel.com>,
        Dinh Nguyen <dinguyen@kernel.org>, agust@denx.de
References: <1532672551-22146-1-git-send-email-appana.durga.rao@xilinx.com>
 <CANk1AXSEWcZ7Oqv5pgpwvJRyyFWk5gPtniXa7T+oe6-uywqEqA@mail.gmail.com>
 <MN2PR02MB6400CD5312983443A67DCC4EDC810@MN2PR02MB6400.namprd02.prod.outlook.com>
 <4476bf39-b665-50d8-fecd-d50687d10ca2@linux.intel.com>
 <20190927182308.GA6797@archbox>
 <f8a9bc07-0705-1318-eba2-8878e839d696@linux.intel.com>
 <20191007212058.GA2929169@archbox>
From:   Thor Thayer <thor.thayer@linux.intel.com>
Message-ID: <bbacc271-a356-2a6c-8e08-0cc65cee6c0e@linux.intel.com>
Date:   Wed, 16 Oct 2019 10:57:02 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191007212058.GA2929169@archbox>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi Moritz,

On 10/7/19 4:20 PM, Moritz Fischer wrote:
> Hi Thor,
> 
> On Mon, Oct 07, 2019 at 01:06:51PM -0500, Thor Thayer wrote:
>> Hi Moritz,
>>
>> On 9/27/19 1:23 PM, Moritz Fischer wrote:
>>> Thor,
>>>
>>> On Fri, Sep 27, 2019 at 09:32:11AM -0500, Thor Thayer wrote:
>>>> Hi Kedar & Moritz,
>>>>
>>>> On 9/27/19 12:13 AM, Appana Durga Kedareswara Rao wrote:
>>>>> Hi Alan,
>>>>>
>>>>> Did you get a chance to send your framework changes to upstream?
>>> No they weren't upstreamed.
>>>
>>>>> @Moritz Fischer: If Alan couldn't send his patch series, Can we take this patch series??
>>>>> Please let me know your thoughts on this.
>>>
>>> Alan had some comments RE: #defines, I'll have to take another look.
>>>>>
>>>>> Regards,
>>>>> Kedar.
>>>>
>>>>
>>>> I'd like to see some mechanism added as well. Our CvP driver needs a way to
>>>> load images to the FPGA over the PCIe bus.
>>>
>>> Can you elaborate a bit on the CvP use-case and how that would work? Who
>>> would use the device how after loading the bitstream?
>>>
>>> Generally there are several use cases that I have collected mentally
>>> over the years:
>>>
>>> I) DFL use case:
>>>     - Mixed-set of drivers: Kernel and Userspace
>>>     - FPGA logic is discoverable through DFL
>>>     - Userspace application wants to reprogram FPGA
>>>
>>> II) DT configfs use case:
>>>     - Mixed-set of drivers: Kernel and Userspace
>>>     - FPGA logic is *not* discoverable (hence DT overlay)
>>>     - Userspace application wants to reprogram FPGA
>>>
>>> III) Thomas' case:
>>>     - Kernel only drivers (pcie bridge, pcie drivers, ...)
>>>     - FPGA logic is fully discoverable (i.e. PCIe endpoint
>>>       implemented in FPGA, connected to SoC via PCIe)
>>>     - Userspace application wants to reprogram FPGA
>>>
>>> IV) VFIO case:
>>>     - Usually exposes either entire device via vfio-pci or part via
>>>       vfio-mdev
>>>     - Loading (basic) bitstream at boot from flash
>>>     - vfio-mdev case can use FPGA region interface + ioctl
>>>     - Full VFIO case is similar to III)
>>>
>>> How does your CvP use case fit in? Collecting all the use-cases would
>>> help with moving forward on coming up with an API :)
>>>
>> The CvP case is the same as III) Thomas' case. The FPGA configuration
>> bitstream is downloaded over the PCIe.
>>
>> The one difference in my case is that there isn't an SoC. This is a Intel
>> host processor connecting to a non-SoC Stratix10/Arria10. The non-SoC
>> A10/S10, boots a minimal image (CvP) setting up the peripheral pins and
>> enabling the PCIe endpoint for CvP downloads.
>>
>> The host can then download bitstreams using the FPGA Manager through debugFS
>> and when the bitstream finishes downloading and the FPGA enters User Mode,
>> the functionality is available for the host to use.
> 
> I am generally confused by this driver. How does it work exactly? What
> happens after altera-cvp binds a PCI device?
> 
> You can use it to download a bitstream (say we had the debugfs
> interface), and then what happens next? How do I use the device? It
> already has a PCI driver bound to it at that point?

Sorry for the delay. In the CvP case, I reboot the host device leaving 
the FPGA board powered so the new PCI interface is enumerated.

There may be a better way. I'll need to research Thomas' use case. There 
may be some good lessons to learn there.

Thanks,

Thor

> 
> What happens next?
> 
> Please tell me that not the only use-case for this is /dev/mem :)
> 
> Thomas' use-case is different in that behind the FPGA device there are
> actual other *discoverable* PCI devices that will get enumerated and
> bind to separate drivers.
> 
> Thanks,
> Moritz
> 
> PS: I'll be out this week on vacation starting tmr so responses might be delayed
> 

