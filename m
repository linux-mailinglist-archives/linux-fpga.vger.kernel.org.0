Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFD2E280894
	for <lists+linux-fpga@lfdr.de>; Thu,  1 Oct 2020 22:43:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730045AbgJAUm6 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 1 Oct 2020 16:42:58 -0400
Received: from mga03.intel.com ([134.134.136.65]:24474 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728382AbgJAUm5 (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 1 Oct 2020 16:42:57 -0400
IronPort-SDR: puIv/AE/V4w2a4QY6oYmfwuIZCgrs4SyhZSlblG97ehHiXKPa77dz22eYB/V8I7MgBi9O+RA64
 UNCngPQdCj5A==
X-IronPort-AV: E=McAfee;i="6000,8403,9761"; a="162909323"
X-IronPort-AV: E=Sophos;i="5.77,325,1596524400"; 
   d="scan'208";a="162909323"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2020 13:42:52 -0700
IronPort-SDR: CQ/Q/+qz4wwFCOWyHQMccNqlRzLsoAnc01s1ZZwtzRRqX+CSx96hWaA23AqlOzSIVUkGV2Im6B
 Ya+cL5WF6Xtg==
X-IronPort-AV: E=Sophos;i="5.77,325,1596524400"; 
   d="scan'208";a="458307814"
Received: from rhweight-mobl2.amr.corp.intel.com (HELO [10.0.2.15]) ([10.212.37.220])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2020 13:42:51 -0700
Subject: Re: [PATCH v1 00/12] Intel FPGA Security Manager Class Driver
To:     "Wu, Hao" <hao.wu@intel.com>, "mdf@kernel.org" <mdf@kernel.org>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     "trix@redhat.com" <trix@redhat.com>,
        "lgoncalv@redhat.com" <lgoncalv@redhat.com>,
        "Xu, Yilun" <yilun.xu@intel.com>,
        "Gerlach, Matthew" <matthew.gerlach@intel.com>
References: <20200904235305.6254-1-russell.h.weight@intel.com>
 <DM6PR11MB38198EC62FA2C63B3E5BC8D0852A0@DM6PR11MB3819.namprd11.prod.outlook.com>
From:   Russ Weight <russell.h.weight@intel.com>
Message-ID: <f8815af0-96cb-f223-ca1f-6158bae34c42@intel.com>
Date:   Thu, 1 Oct 2020 13:42:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <DM6PR11MB38198EC62FA2C63B3E5BC8D0852A0@DM6PR11MB3819.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org



On 9/5/20 7:13 AM, Wu, Hao wrote:
>> Subject: [PATCH v1 00/12] Intel FPGA Security Manager Class Driver
>>
>>
>> These patches depend on the patchset: "add regmap-spi-avmm & Intel
>> Max10 BMC chip support" which is currently under review.
>>
>>            --------------------------------------------------
>>
>> This patchset introduces the Intel Security Manager class driver
>> for managing secure updates on Intel FPGA Cards. It also provides
>> the n3000bmc-secure mfd sub-driver for the MAX10 BMC for the n3000
>> Programmable Acceleration Cards (PAC). The n3000bmc-secure driver
>> is implemented using the Intel Security Manager class driver.
> So this patchset contains two parts
> (1) adding a new class driver for Intel FPGA secure update.
> (2) a new driver which uses (1) to implement secure update for n3000 PAC.
Yes - that is correct
>
> And only part (2) depends on "Intel MAX10 BMC chip support" patchset.
> (Maybe you can provide a link to that thread).
>
> Is my understanding correct? If yes, is it possible to reorder these patches?
> At least there is no dependency on the class driver patches, right?
Yes - I'm splitting the patch set, and I'll provide links for the dependencies
on the MAX10 BMC Secure Engine patch set.
>
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
> Maybe you can explain a little more on why we need to have this done
> via a class driver not just some internal code in max10 driver? This class
> driver will be reused in different cases? And why adding a new class
> driver not just reuse or extend fpga manager (existing fpga mgr is used
> to update fpga too).
Yes - I'll so that in the next patch set.
>
>> The n3000bmc-secure driver instantiates the Intel Security Manager
>> class driver and provides the callback functions required to support
>> secure updates on Intel n3000 PAC devices.
>>
>> Russ Weight (12):
>>   fpga: fpga security manager class driver
> Intel FPGA Security Manager?
Yes - I'll make that change
>
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
> For these patches, is it possible to have a better title for these patches.
> Then it will be easier to know which component this patch is going to modify.
> e.g. fpga: ifpga-sec-mgr: xxxxxx
Yes. Thanks for the comments.

- Russ
>
> Thanks
> Hao
>
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
>> --
>> 2.17.1

