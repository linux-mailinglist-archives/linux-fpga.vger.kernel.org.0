Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F5BC7CD865
	for <lists+linux-fpga@lfdr.de>; Wed, 18 Oct 2023 11:41:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbjJRJj6 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 18 Oct 2023 05:39:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjJRJj5 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 18 Oct 2023 05:39:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49DA8B0
        for <linux-fpga@vger.kernel.org>; Wed, 18 Oct 2023 02:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697621947;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VrslnXR1a0nTDSwEmyOiXoaLXqr6LLZ+VDAPzsK58ek=;
        b=gkGAUSqCIlS1pHJ7N3w+Vho0wtREAn5phmk6s/7kGQcRTS+vKgC3mtr5rhKQpCsb35y6pk
        skuhkpP1MDo/WDWEu5pOoAkm6IsoVs3a5DEUx4QwYDMXEn4HJtPpC0RPvYt+kf80xGIrGG
        RcmQYF8kx/lBtK+tNYpYnXxQbWhqNTE=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-215-zlEH0eZZOjqX447P8jhKOA-1; Wed, 18 Oct 2023 05:39:06 -0400
X-MC-Unique: zlEH0eZZOjqX447P8jhKOA-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-66d040c58eeso76195966d6.3
        for <linux-fpga@vger.kernel.org>; Wed, 18 Oct 2023 02:39:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697621945; x=1698226745;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VrslnXR1a0nTDSwEmyOiXoaLXqr6LLZ+VDAPzsK58ek=;
        b=SQhWjxTEMbLoJcOwV+ukGpagbxFQNWdGwb7rdgeGGCqv70gBmzKSNjFugujrgd5wYv
         sT69EC4jjhUA22i+/Q1UeWbcdUPyl4vXSHXAg+wYKHx3mujpD56UL8cvS+u3Yury2GD2
         PxbGBNVtnV8aFbLUBzLVST3tgkJTwwDWin4aqKMNCmL8gC+JtqIjdpSE8N/ySDOD+2l/
         taDQtySJs3dg1ewkkOUDx1MTXa/8PxKaGSsxhoSVIDRB6u83rAX5ZlXlzQHpVVRaMpbG
         t8m/X3GHdnKCqcTBULa7uygprGyLfP1ZVvzGnfnBHdNpjaJNwXPR8XrIvfsAeW6Ix+6R
         jkMA==
X-Gm-Message-State: AOJu0YwVtjK/vm1uq4Q6XTbg5DFZAHsz/gSOFAkgzYrlUtYYG/XYNEkL
        5PFHnVrP0FCMgNF9wArtLN547hOyhsk4QlgpeuSRI1WBMXzBWDaZ0dEYH6koMd/hRya11vt9nBI
        risGrY3WjiTJPjSghchF1
X-Received: by 2002:a0c:f0d4:0:b0:66c:eeb8:4226 with SMTP id d20-20020a0cf0d4000000b0066ceeb84226mr4687237qvl.12.1697621945507;
        Wed, 18 Oct 2023 02:39:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG1zRn8CkFrguZ+iRkQAubySXLnbkajaI4Ccc88wEbAg6rtxcEWTq+dh8ugeIKyyHw1re+QOA==
X-Received: by 2002:a0c:f0d4:0:b0:66c:eeb8:4226 with SMTP id d20-20020a0cf0d4000000b0066ceeb84226mr4687224qvl.12.1697621945214;
        Wed, 18 Oct 2023 02:39:05 -0700 (PDT)
Received: from [192.168.9.16] (net-2-34-31-107.cust.vodafonedsl.it. [2.34.31.107])
        by smtp.gmail.com with ESMTPSA id q12-20020a0ce20c000000b00668bb8be252sm1202961qvl.60.2023.10.18.02.39.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Oct 2023 02:39:04 -0700 (PDT)
Message-ID: <e178f915-fc65-48a1-abab-05d1202319a4@redhat.com>
Date:   Wed, 18 Oct 2023 11:39:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] FPGA Manager changes for 6.6-final
To:     Greg KH <gregkh@linuxfoundation.org>,
        Xu Yilun <yilun.xu@linux.intel.com>
Cc:     yilun.xu@intel.com, linux-fpga@vger.kernel.org, hao.wu@intel.com,
        mdf@kernel.org
References: <ZS6hhlvjUcqyv8zL@yilunxu-OptiPlex-7050>
 <2023101730-budding-spree-1471@gregkh>
 <ZS88oHe8T69/Kks7@yilunxu-OptiPlex-7050>
 <2023101825-ligament-undergrad-cc4d@gregkh>
Content-Language: en-US
From:   Marco Pagani <marpagan@redhat.com>
In-Reply-To: <2023101825-ligament-undergrad-cc4d@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org



On 18/10/23 09:50, Greg KH wrote:
> On Wed, Oct 18, 2023 at 10:02:08AM +0800, Xu Yilun wrote:
>> On Tue, Oct 17, 2023 at 07:17:29PM +0200, Greg KH wrote:
>>> On Tue, Oct 17, 2023 at 11:00:22PM +0800, Xu Yilun wrote:
>>>> The following changes since commit 6465e260f48790807eef06b583b38ca9789b6072:
>>>>
>>>>   Linux 6.6-rc3 (2023-09-24 14:31:13 -0700)
>>>>
>>>> are available in the Git repository at:
>>>>
>>>>   git://git.kernel.org/pub/scm/linux/kernel/git/fpga/linux-fpga tags/fpga-for-6.6-final
>>>>
>>>> for you to fetch changes up to 6a935361500a21ef11a82814ee66fc58e59813f7:
>>>>
>>>>   fpga: Fix memory leak for fpga_region_test_class_find() (2023-10-12 12:59:29 +0800)
>>>>
>>>> ----------------------------------------------------------------
>>>> FPGA Manager changes for 6.6-final
>>>>
>>>> FPGA KUnit test:
>>>>
>>>> - Marco's change fixes null-ptr-deref when try_module_get()
>>>> - Jinjie's change fixes a memory leak issue
>>>>
>>>> Intel m10 bmc secure update:
>>>>
>>>> - Maintainer change from Russ Weight to Peter Colberg
>>>>
>>>> All patches have been reviewed on the mailing list, and have been in the
>>>> last linux-next releases (as part of our fixes branch)
>>>>
>>>> Signed-off-by: Xu Yilun <yilun.xu@intel.com>
>>>>
>>>> ----------------------------------------------------------------
>>>> Jinjie Ruan (1):
>>>>       fpga: Fix memory leak for fpga_region_test_class_find()
>>>>
>>>> Marco Pagani (4):
>>>>       fpga: add helpers for the FPGA KUnit test suites.
>>>>       fpga: add a platform driver to the FPGA Manager test suite
>>>>       fpga: add a platform driver to the FPGA Bridge test suite
>>>>       fpga: add a platform driver to the FPGA Region test suite
>>>
>>> Why are all of these test suite patches here?  They are not relevant for
>>> 6.6-final as they do not resolve anything.
>>
>> Maybe the subjects indicate no bug fixing, but they fix null-ptr-deref
>> issues when modprobe fpga-mgr/bridge/region-test.
> 
> That's not obvious, sorry.  So are the tests broken right now so that
> they don't work at all?

They were broken only when compiled and run as modules.

> 
>> In fpga-mgr-test, the pdev->dev->driver is not assigned, so when
>>
>>   fpga_mgr_test_get()->try_module_get(dev->parent->driver->owner)
> 
> That's a horrible line and should be fixed.  How do you know if a device
> has a parent, or if that parent has a driver?  You don't, that should be
> fixed instead.
> 
> And module_get on a driver pointer is also never a good idea for other
> reasons, why is this happening at all?  It shouldn't be needed if the
> code is set up properly (i.e. the unloading of a driver will handle the
> shutdown and reference counting properly, no need to try to use module
> references at all.)

You are right, but fixing the fpga core is outside the scope of my patches.
My intent was to improve the test suite by adding fake drivers irrespective
of the fpga core quirks. I might try to send an RFC later to improve the
fpga core.

> 
>> NULL ptr is referenced.
>>
>> So do fpga-bridge/region-test.
>>
>> Patch #1 adds a common helper to generate a platform driver.
> 
> Don't abuse platform devices/drivers like this, this is not a platform
> device or driver.  If you really want to do this, use a real driver and
> device, not a platform one please.

Other test suites, like DRM suites, already use fake platform devices and
drivers. Moreover, many real FPGA IPs, like reconfiguration controllers and
bridges, are indeed modeled as platform devices. What is the benefit of
using a real driver and device?

> 
>> Patch #2/3/4 fix the issues by matching the driver to pdev.
>>
>> See:
>> Closes: https://lore.kernel.org/linux-fpga/4d51e87f-830a-adae-d6f7-6aed9433fdc6@huawei.com/
>> Closes: https://lore.kernel.org/linux-fpga/f2b30203-1a67-4533-eddc-b380044e2e68@huawei.com/
>> Closes: https://lore.kernel.org/linux-fpga/d557b4ee-4b3a-8747-bdda-0ed480212a63@huawei.com/
> 
> Want to just disable all of these from the build entirely for now and
> then fix them up properly for 6.7?
> 
> thanks,
> 
> greg k-h
> 

