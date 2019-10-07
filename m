Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C5C2CEB67
	for <lists+linux-fpga@lfdr.de>; Mon,  7 Oct 2019 20:05:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728583AbfJGSFB (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 7 Oct 2019 14:05:01 -0400
Received: from mga03.intel.com ([134.134.136.65]:23097 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728665AbfJGSFB (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 7 Oct 2019 14:05:01 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Oct 2019 11:04:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,269,1566889200"; 
   d="scan'208";a="218038008"
Received: from tthayer-hp-z620.an.intel.com (HELO [10.122.105.146]) ([10.122.105.146])
  by fmsmga004.fm.intel.com with ESMTP; 07 Oct 2019 11:04:58 -0700
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
        Dinh Nguyen <dinguyen@kernel.org>
References: <1532672551-22146-1-git-send-email-appana.durga.rao@xilinx.com>
 <CANk1AXSEWcZ7Oqv5pgpwvJRyyFWk5gPtniXa7T+oe6-uywqEqA@mail.gmail.com>
 <MN2PR02MB6400CD5312983443A67DCC4EDC810@MN2PR02MB6400.namprd02.prod.outlook.com>
 <4476bf39-b665-50d8-fecd-d50687d10ca2@linux.intel.com>
 <20190927182308.GA6797@archbox>
From:   Thor Thayer <thor.thayer@linux.intel.com>
Message-ID: <f8a9bc07-0705-1318-eba2-8878e839d696@linux.intel.com>
Date:   Mon, 7 Oct 2019 13:06:51 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190927182308.GA6797@archbox>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi Moritz,

On 9/27/19 1:23 PM, Moritz Fischer wrote:
> Thor,
> 
> On Fri, Sep 27, 2019 at 09:32:11AM -0500, Thor Thayer wrote:
>> Hi Kedar & Moritz,
>>
>> On 9/27/19 12:13 AM, Appana Durga Kedareswara Rao wrote:
>>> Hi Alan,
>>>
>>> Did you get a chance to send your framework changes to upstream?
> No they weren't upstreamed.
> 
>>> @Moritz Fischer: If Alan couldn't send his patch series, Can we take this patch series??
>>> Please let me know your thoughts on this.
> 
> Alan had some comments RE: #defines, I'll have to take another look.
>>>
>>> Regards,
>>> Kedar.
>>
>>
>> I'd like to see some mechanism added as well. Our CvP driver needs a way to
>> load images to the FPGA over the PCIe bus.
> 
> Can you elaborate a bit on the CvP use-case and how that would work? Who
> would use the device how after loading the bitstream?
> 
> Generally there are several use cases that I have collected mentally
> over the years:
> 
> I) DFL use case:
>    - Mixed-set of drivers: Kernel and Userspace
>    - FPGA logic is discoverable through DFL
>    - Userspace application wants to reprogram FPGA
> 
> II) DT configfs use case:
>    - Mixed-set of drivers: Kernel and Userspace
>    - FPGA logic is *not* discoverable (hence DT overlay)
>    - Userspace application wants to reprogram FPGA
> 
> III) Thomas' case:
>    - Kernel only drivers (pcie bridge, pcie drivers, ...)
>    - FPGA logic is fully discoverable (i.e. PCIe endpoint
>      implemented in FPGA, connected to SoC via PCIe)
>    - Userspace application wants to reprogram FPGA
> 
> IV) VFIO case:
>    - Usually exposes either entire device via vfio-pci or part via
>      vfio-mdev
>    - Loading (basic) bitstream at boot from flash
>    - vfio-mdev case can use FPGA region interface + ioctl
>    - Full VFIO case is similar to III)
> 
> How does your CvP use case fit in? Collecting all the use-cases would
> help with moving forward on coming up with an API :)
> 
The CvP case is the same as III) Thomas' case. The FPGA configuration 
bitstream is downloaded over the PCIe.

The one difference in my case is that there isn't an SoC. This is a 
Intel host processor connecting to a non-SoC Stratix10/Arria10. The 
non-SoC A10/S10, boots a minimal image (CvP) setting up the peripheral 
pins and enabling the PCIe endpoint for CvP downloads.

The host can then download bitstreams using the FPGA Manager through 
debugFS and when the bitstream finishes downloading and the FPGA enters 
User Mode, the functionality is available for the host to use.

>>
>> It wasn't clear to me from the discussion on Alan's patchset[1] that the
>> debugfs was acceptable to the mainline. I'd be happy to resurrect that
>> patchset with the suggested changes.
> 
> Back then we decided to not move forward with the debugfs patchset since
> it's essentially cat foo.bin > /dev/xdevcfg / cat bar.rbf > /dev/fpga0
> in disguise. Which is why I vetoed it back then.
> 
>> Since debugfs isn't enabled for production, are there any alternatives?
>>
>> Alan sent a RFC [2] for loading FIT images through the sysfs.
>>
>> The RFC described a FIT image that included FPGA image specific information
>> to be included with the image (for systems running without device tree like
>> our PCIe bus FPGA CvP).
> 
> Yeah I had originally suggested that as a mechanim to make FPGA images
> discoverable by the kernel. I still think the idea has merit, however it
> will run into the same issues that the configfs interface ran into w.r.t
> using dt-overlays.
> 
> Generally I'd like to see a solution that exposes the *same* interface
> to DT and not DT systems to userspace.
> 
> Using FIT headers one could go ahead and design something along the
> lines of what DFL is doing, except for instead of parsing the DFL in the
> logic, one would parse the FIT header to create subdevices.
> 
>> Unfortunately, I believe this has the same uphill battle that the Device
>> Tree Overlay patches[3] have to getting accepted.
> 
> See above. While I'm happy to discuss this more I atm don't have the
> bandwidth to push the DT work any further.

Understood. I'm still coming up to speed on the variations of FPGA 
enablement but I'm happy to help where I can.

Thanks.

> 
> Thanks,
> Moritz
> 

