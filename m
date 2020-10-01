Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B46F327F694
	for <lists+linux-fpga@lfdr.de>; Thu,  1 Oct 2020 02:19:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731808AbgJAATT (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 30 Sep 2020 20:19:19 -0400
Received: from mga06.intel.com ([134.134.136.31]:14178 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730268AbgJAATT (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 30 Sep 2020 20:19:19 -0400
IronPort-SDR: Wxka46XZp0xp2MIF6Eo3Iz2pccBCrikkGLsZVoMCkvSLjaYMYP0HrwfkmZKwXk418ZAX6lUSa8
 1Ui2pbri+0kA==
X-IronPort-AV: E=McAfee;i="6000,8403,9760"; a="224186366"
X-IronPort-AV: E=Sophos;i="5.77,322,1596524400"; 
   d="scan'208";a="224186366"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2020 17:19:15 -0700
IronPort-SDR: DxQVWFOEvZZ4hRXTL1/AnxrxvkeCWRQTFbnfyPUH33DsPQi12X7v46mnyo9bV1A2+/BdCZNHRy
 bVtlYmOLRZYA==
X-IronPort-AV: E=Sophos;i="5.77,322,1596524400"; 
   d="scan'208";a="457871009"
Received: from rhweight-mobl2.amr.corp.intel.com (HELO [10.0.2.15]) ([10.212.91.128])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2020 17:19:14 -0700
Subject: Re: [PATCH v1 00/12] Intel FPGA Security Manager Class Driver
To:     Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>
References: <20200904235305.6254-1-russell.h.weight@intel.com>
 <4d554f31-1267-92cc-f717-00992144c41b@redhat.com>
From:   Russ Weight <russell.h.weight@intel.com>
Message-ID: <7f9b6090-a265-11ec-3ee4-14a2a63206f8@intel.com>
Date:   Wed, 30 Sep 2020 17:19:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <4d554f31-1267-92cc-f717-00992144c41b@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org



On 9/5/20 10:16 AM, Tom Rix wrote:
> resending.
> sorry for blowing past 80 chars.
>
> On 9/4/20 4:52 PM, Russ Weight wrote:
>> These patches depend on the patchset: "add regmap-spi-avmm & Intel
>> Max10 BMC chip support" which is currently under review.
> https://marc.info/?l=linux-kernel&m=159782274232229&w=2
>
> regmap-spi-avmm is in linux-next.
>
> max10 is not. however applying it does not resolve resolve
> git am conflicts with yesterday's linux-next.
> I normally build the larger patchsets as a test.
I have rebased to a more recent version of linux-next. I'll make sure to
send dependency information with the next patch set. I'll also split it
into two patch sets, since the class driver has no dependencies on patches
that are in flight.
>
>>            --------------------------------------------------
>>
>> This patchset introduces the Intel Security Manager class driver
>> for managing secure updates on Intel FPGA Cards. It also provides
>> the n3000bmc-secure mfd sub-driver for the MAX10 BMC for the n3000
>> Programmable Acceleration Cards (PAC). The n3000bmc-secure driver
>> is implemented using the Intel Security Manager class driver.
>>
>> The Intel Security Manager class driver provides a common API for
>> user-space tools to manage updates for Secure FPGA devices. Device
>> drivers that instantiate the Intel Security Manager class driver will
>> interact with the HW secure update engine in order to transfer
>> new FPGA and BMC images to FLASH so that they will be automatically
>> loaded when the FPGA card reboots.
>>
>> The API consists of sysfs nodes and supports the following functions:
>>
>> (1) Instantiate and monitor a secure update
>> (2) Display security information including: Root Entry Hashes (REH),
>>     Cancelled Code Signing Keys (CSK), and flash update counts for
>>     both BMC and FPGA images.
>>
>> Secure updates make use of the request_firmware framework, which
>> requires that image files are accessible under /lib/firmware. A request
>> for a secure update returns immediately, while the update itself
>> proceeds in the context of a kernel worker thread. Sysfs files provide
>> a means for monitoring the progress of a secure update and for
>> retrieving error information in the event of a failure.
>>
>> The n3000bmc-secure driver instantiates the Intel Security Manager
>> class driver and provides the callback functions required to support
>> secure updates on Intel n3000 PAC devices.
> This is a good description.  Because security manager is a new
> interface, there should be a Documentation/fpga/ifpga-sec-mgr.rst
> to collect this description.
Sure - I'll create the documentation file.
>
> How will these devices be discovered ? n3000 is a dfl device,
> will there be a dfl feature id for it at some point ? 

The n3000 implementation of the MAX10 BMC, and eventually the d5005
implementation of the MAX10 BMC, both instantiate the MAX10 BMC Secure
Engine as a sub device. There is a dfl feature ID for the SPI interface
to the BMC, but no dfl feature ID for the secure engine itself.

Given that the security manager is dependent on other hardware and
firmware to manage the root entry hashes and to verify and program
the images, I think it is safe to say that implementations of the
security manager will always be implemented as sub devices. I can't
think of a case for giving it it's own dfl feature ID.

The class driver, of course, is an abstraction above the MAX10 BMC
implementation.
> Can you describe if/how the security manager would live outside
> of dfl ?  I am wondering why this shouldn't be dfl-sec-mgr. 
The Intel FPGA Security Manager could be used by Intel FPGA devices that
are implemented without a Device Feature List.

> I did not see any version handling.  How would this sw adapt
> to a newer or older version of the bmc interface?
There are some slight differences in the implementation of the MAX10 BMC
Secure Engine between the n3000 and d5005 implementations. The d5005
support is not in the current patch set, but when it is included there
will be a different device name to indicate which code variations should
be active. Also, different platform data can be passed into the secure
engine by the parent MAX10 device if needed for new versions of the BMC.

Thanks,
- Russ
>
> Tom
>
>> Russ Weight (12):
>>   fpga: fpga security manager class driver
>>   fpga: create intel max10 bmc security engine
>>   fpga: expose max10 flash update counts in sysfs
>>   fpga: expose max10 canceled keys in sysfs
>>   fpga: enable secure updates
>>   fpga: add max10 secure update functions
>>   fpga: expose sec-mgr update status
>>   fpga: expose sec-mgr update errors
>>   fpga: expose sec-mgr update size
>>   fpga: enable sec-mgr update cancel
>>   fpga: expose hardware error info in sysfs
>>   fpga: add max10 get_hw_errinfo callback func
>>
>>  .../ABI/testing/sysfs-class-ifpga-sec-mgr     | 151 ++++
>>  MAINTAINERS                                   |   8 +
>>  drivers/fpga/Kconfig                          |  20 +
>>  drivers/fpga/Makefile                         |   6 +
>>  drivers/fpga/ifpga-sec-mgr.c                  | 669 ++++++++++++++++++
>>  drivers/fpga/intel-m10-bmc-secure.c           | 557 +++++++++++++++
>>  include/linux/fpga/ifpga-sec-mgr.h            | 201 ++++++
>>  include/linux/mfd/intel-m10-bmc.h             | 116 +++
>>  8 files changed, 1728 insertions(+)
>>  create mode 100644 Documentation/ABI/testing/sysfs-class-ifpga-sec-mgr
>>  create mode 100644 drivers/fpga/ifpga-sec-mgr.c
>>  create mode 100644 drivers/fpga/intel-m10-bmc-secure.c
>>  create mode 100644 include/linux/fpga/ifpga-sec-mgr.h
>>

