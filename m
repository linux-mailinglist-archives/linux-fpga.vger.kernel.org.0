Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21FE9408AC8
	for <lists+linux-fpga@lfdr.de>; Mon, 13 Sep 2021 14:12:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239851AbhIMMNy (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 13 Sep 2021 08:13:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50418 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237106AbhIMMNx (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 13 Sep 2021 08:13:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631535157;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vSMeQm4fsiThkonXMhr3sKRDMnUc6h1VcL9Yy6VW9yg=;
        b=hqp44VcTqLM2vlKWcw2j2RykqAvmPmzRTLqdcdFwy+8eBD2CGJg+fSYXY6sRlM4RUmeZ30
        3osdSMsztMtJC6Wiv164iE+RJAGzj1lJRbNvQF/yZKfpbq7rYpPBr8EZKHvMn65qaNk6zG
        1iDwN2qyETd8966VErmU4X61UPqctBM=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-589-1c0PqNDsNUSOuWed_44HsA-1; Mon, 13 Sep 2021 08:12:36 -0400
X-MC-Unique: 1c0PqNDsNUSOuWed_44HsA-1
Received: by mail-qk1-f200.google.com with SMTP id k12-20020a05620a0b8c00b003d5c8646ec2so40937296qkh.20
        for <linux-fpga@vger.kernel.org>; Mon, 13 Sep 2021 05:12:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=vSMeQm4fsiThkonXMhr3sKRDMnUc6h1VcL9Yy6VW9yg=;
        b=Q5yfaPlkBT6f+48VKYqmianJ3/veYL0F3+W87M1H2Sq6YmQ3A0naORRPmpKiXuzdNe
         7DBXcRNz8XslDtqDFl8cDquiZNB4p0ocQVNDVRN/VDiR55LU8dZEez3Fsf3GvQTP+4fu
         L5AJJNx4wn2u+DCxnrG4/nFxzy83MO+QQI+MLMlMaWaskpiRQwFH+uheXjvVW38hZ33k
         WYtw/l8KtEnS8mcCb30+683UuFsPrJHXdbdJfu044k93wWSdrWEinZSdc3o/NmxSOWVn
         SgI6uKMxMRXvcUeYBojec8kBqfVD7pCL7gBiWiBW3n2ldKNlk7I684pZXMzbmdCsexkW
         YW2Q==
X-Gm-Message-State: AOAM5332LEXLoHFx0AUZb0Vqo6DbVAQtizsfF1CBpfGqwbcxgo1hTZPC
        6koYrX3CkaVi8ZG/8Y8egar7ZSXmUiMKUX0tSdb+i0cmehKf8iFIVVtFWZNyG1isjdluIWrpMcn
        EqFpIYakGPFag3TGi2Ncj9g==
X-Received: by 2002:a0c:aa01:: with SMTP id d1mr10242262qvb.47.1631535156047;
        Mon, 13 Sep 2021 05:12:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwsB3wBj1DUtV27jjdM7xr8evfxgFGSlShP5h/DPjPcqyz2uJyl2ADEiP+lnH+apzuQnS58mA==
X-Received: by 2002:a0c:aa01:: with SMTP id d1mr10242237qvb.47.1631535155782;
        Mon, 13 Sep 2021 05:12:35 -0700 (PDT)
Received: from localhost.localdomain (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id i14sm5062462qka.66.2021.09.13.05.12.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Sep 2021 05:12:35 -0700 (PDT)
Subject: Re: [PATCH v14 1/4] fpga: m10bmc-sec: create max10 bmc secure update
 driver
To:     Xu Yilun <yilun.xu@intel.com>
Cc:     Russ Weight <russell.h.weight@intel.com>, mdf@kernel.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        lgoncalv@redhat.com, hao.wu@intel.com, matthew.gerlach@intel.com
References: <20210909233304.5650-1-russell.h.weight@intel.com>
 <20210909233304.5650-2-russell.h.weight@intel.com>
 <20210910151335.GB757507@yilunxu-OptiPlex-7050>
 <1e4a9cc9-4390-1c9d-5ec0-7e9295158dfa@intel.com>
 <ce3039c5-d18a-87d5-229d-5ff571c2aaa9@redhat.com>
 <20210913053747.GE754505@yilunxu-OptiPlex-7050>
From:   Tom Rix <trix@redhat.com>
Message-ID: <41b42ae2-6cbc-fec2-44b3-6353507e1b02@redhat.com>
Date:   Mon, 13 Sep 2021 05:12:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210913053747.GE754505@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


On 9/12/21 10:37 PM, Xu Yilun wrote:
> On Sat, Sep 11, 2021 at 12:04:07PM -0700, Tom Rix wrote:
>> On 9/10/21 1:27 PM, Russ Weight wrote:
>>> On 9/10/21 8:13 AM, Xu Yilun wrote:
>>>> On Thu, Sep 09, 2021 at 04:33:01PM -0700, Russ Weight wrote:
>>>>> Create a sub driver for the FPGA Card BMC in order to support secure
>>>>> updates.  This sub-driver will invoke an instance of the FPGA Image Load
>>>>> class driver for the image load portion of the update.
>>>>>
>>>>> This patch creates the MAX10 BMC Secure Update driver and provides sysfs
>>>>> files for displaying the current root entry hashes for the FPGA static
>>>>> region, the FPGA PR region, and the MAX10 BMC.
>>>>>
>>>>> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
>>>>> Reviewed-by: Tom Rix <trix@redhat.com>
>>>>> ---
>>>>> v14:
>>>>>     - Changed symbol and text references to reflect the renaming of the
>>>>>       Security Manager Class driver to FPGA Image Load.
>>>>> v13:
>>>>>     - Updated copyright to 2021
>>>>>     - Updated ABI documentation date and kernel version
>>>>>     - Call updated fpga_sec_mgr_register() and fpga_sec_mgr_unregister()
>>>>>       functions instead of devm_fpga_sec_mgr_create() and
>>>>>       devm_fpga_sec_mgr_register().
>>>>> v12:
>>>>>     - Updated Date and KernelVersion fields in ABI documentation
>>>>> v11:
>>>>>     - Added Reviewed-by tag
>>>>> v10:
>>>>>     - Changed the path expressions in the sysfs documentation to
>>>>>       replace the n3000 reference with something more generic to
>>>>>       accomodate other devices that use the same driver.
>>>>> v9:
>>>>>     - Rebased to 5.12-rc2 next
>>>>>     - Updated Date and KernelVersion in ABI documentation
>>>>> v8:
>>>>>     - Previously patch 2/6, otherwise no change
>>>>> v7:
>>>>>     - Updated Date and KernelVersion in ABI documentation
>>>>> v6:
>>>>>     - Added WARN_ON() call for (sha_num_bytes / stride) to assert
>>>>>       that the proper count is passed to regmap_bulk_read().
>>>>> v5:
>>>>>     - No change
>>>>> v4:
>>>>>     - Moved sysfs files for displaying the root entry hashes (REH)
>>>>>       from the FPGA Security Manager class driver to here. The
>>>>>       m10bmc_reh() and m10bmc_reh_size() functions are removed and
>>>>>       the functionality from these functions is moved into a
>>>>>       show_root_entry_hash() function for displaying the REHs.
>>>>>     - Added ABI documentation for the new sysfs entries:
>>>>>       sysfs-driver-intel-m10-bmc-secure
>>>>>     - Updated the MAINTAINERS file to add the new ABI documentation
>>>>>       file: sysfs-driver-intel-m10-bmc-secure
>>>>>     - Removed unnecessary ret variable from m10bmc_secure_probe()
>>>>>     - Incorporated new devm_fpga_sec_mgr_register() function into
>>>>>       m10bmc_secure_probe() and removed the m10bmc_secure_remove()
>>>>>       function.
>>>>> v3:
>>>>>     - Changed from "Intel FPGA Security Manager" to FPGA Security Manager"
>>>>>     - Changed: iops -> sops, imgr -> smgr, IFPGA_ -> FPGA_, ifpga_ to fpga_
>>>>>     - Changed "MAX10 BMC Secure Engine driver" to "MAX10 BMC Secure
>>>>>       Update driver"
>>>>>     - Removed wrapper functions (m10bmc_raw_*, m10bmc_sys_*). The
>>>>>       underlying functions are now called directly.
>>>>>     - Changed "_root_entry_hash" to "_reh", with a comment explaining
>>>>>       what reh is.
>>>>> v2:
>>>>>     - Added drivers/fpga/intel-m10-bmc-secure.c file to MAINTAINERS.
>>>>>     - Switched to GENMASK(31, 16) for a couple of mask definitions.
>>>>>     - Moved MAX10 BMC address and function definitions to a separate
>>>>>       patch.
>>>>>     - Replaced small function-creation macros with explicit function
>>>>>       declarations.
>>>>>     - Removed ifpga_sec_mgr_init() and ifpga_sec_mgr_uinit() functions.
>>>>>     - Adapted to changes in the Intel FPGA Security Manager by splitting
>>>>>       the single call to ifpga_sec_mgr_register() into two function
>>>>>       calls: devm_ifpga_sec_mgr_create() and ifpga_sec_mgr_register().
>>>>> ---
>>>>>    .../testing/sysfs-driver-intel-m10-bmc-secure |  29 ++++
>>>>>    MAINTAINERS                                   |   2 +
>>>>>    drivers/fpga/Kconfig                          |  11 ++
>>>>>    drivers/fpga/Makefile                         |   3 +
>>>>>    drivers/fpga/intel-m10-bmc-secure.c           | 145 ++++++++++++++++++
>>>>>    5 files changed, 190 insertions(+)
>>>>>    create mode 100644 Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-secure
>>>>>    create mode 100644 drivers/fpga/intel-m10-bmc-secure.c
>>>>>
>>>>> diff --git a/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-secure b/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-secure
>>>>> new file mode 100644
>>>>> index 000000000000..363403ce992d
>>>>> --- /dev/null
>>>>> +++ b/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-secure
>>>>> @@ -0,0 +1,29 @@
>>>>> +What:		/sys/bus/platform/drivers/intel-m10bmc-secure/.../security/sr_root_entry_hash
>>>>> +Date:		Aug 2021
>>>>> +KernelVersion:	5.15
>>>>> +Contact:	Russ Weight <russell.h.weight@intel.com>
>>>>> +Description:	Read only. Returns the root entry hash for the static
>>>>> +		region if one is programmed, else it returns the
>>>>> +		string: "hash not programmed".  This file is only
>>>>> +		visible if the underlying device supports it.
>>>>> +		Format: "0x%x".
>>>>> +
>>>>> +What:		/sys/bus/platform/drivers/intel-m10bmc-secure/.../security/pr_root_entry_hash
>>>>> +Date:		Aug 2021
>>>>> +KernelVersion:	5.15
>>>>> +Contact:	Russ Weight <russell.h.weight@intel.com>
>>>>> +Description:	Read only. Returns the root entry hash for the partial
>>>>> +		reconfiguration region if one is programmed, else it
>>>>> +		returns the string: "hash not programmed".  This file
>>>>> +		is only visible if the underlying device supports it.
>>>>> +		Format: "0x%x".
>>>>> +
>>>>> +What:		/sys/bus/platform/drivers/intel-m10bmc-secure/.../security/bmc_root_entry_hash
>>>>> +Date:		Aug 2021
>>>>> +KernelVersion:	5.15
>>>>> +Contact:	Russ Weight <russell.h.weight@intel.com>
>>>>> +Description:	Read only. Returns the root entry hash for the BMC image
>>>>> +		if one is programmed, else it returns the string:
>>>>> +		"hash not programmed".  This file is only visible if the
>>>>> +		underlying device supports it.
>>>>> +		Format: "0x%x".
>>>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>>>> index e3fbc1bde9bc..cf93835b4775 100644
>>>>> --- a/MAINTAINERS
>>>>> +++ b/MAINTAINERS
>>>>> @@ -7363,8 +7363,10 @@ M:	Russ Weight <russell.h.weight@intel.com>
>>>>>    L:	linux-fpga@vger.kernel.org
>>>>>    S:	Maintained
>>>>>    F:	Documentation/ABI/testing/sysfs-class-fpga-image-load
>>>>> +F:	Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-secure
>>>> Should we change the name of the driver? Some keywords like "image load"
>>>> or "firmware update" should be in the name.
>>> I considered that. The image-upload functionality is a subset of  this
>>> driver. It also exposes security collateral via sysfs, and the image-load
>>> triggers and power-on-image sysfs files will probably end up in this
>>> driver too.
>>>
>>> The current driver name is intel-m10-bmc-secure. Do we need to keep
>>> "intel-m10-bmc" in the name?
>>>
>>> intel-m10-bmc-sec-fw-update?
>>> intel-m10-bmc-sec-update?
>>>
>>> What do you think? Any other suggestions?
> The single word "secure" is quite indistinct to me. I think
> intel-m10-bmc-sec-update is much better.

This fine.

Should it move to mfd/ ?

Tom

>
>> The prefix intel-m10-bmc-sec is clunky and confuses me because I think of
>> mfd/intel-m10-bmc.c
> The secure update engine is now implemented in MAX10 bmc. The driver
> code also assumes it is always a sub device of MAX10 bmc. So my
> preference is we keep the prefix.
>
>> How about
>>
>> dfl-image-load ?
> There may be several secure update engines for DFL based FPGAs. So we
> may be more specific.
>
> Thanks,
> Yilun
>

