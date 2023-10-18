Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B11DB7CE163
	for <lists+linux-fpga@lfdr.de>; Wed, 18 Oct 2023 17:42:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232349AbjJRPlB (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 18 Oct 2023 11:41:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232406AbjJRPlA (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 18 Oct 2023 11:41:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5511911B
        for <linux-fpga@vger.kernel.org>; Wed, 18 Oct 2023 08:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697643614;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CZEA4k3kA7HlbpTDUQc76jRVTB9sGHxQtfYQNxiSXx8=;
        b=iK2OOjW++qDRZoQsheU/T46PQCVAE/OJvzArg2t3CxtNYHi9JmHq7n28n+V/ioj2M/npCL
        nipBet0TxnBYL0wkUVUmlyOfzbSpcP75u1Lu9kRw2UEqf7xwA9y9eFdeMdm/3e6825WmBv
        Xd0K9usPYsZEzsgOO/nJDGMCj9TurAo=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-286-uZapHAt1OfiiQ1oCk2oVOg-1; Wed, 18 Oct 2023 11:40:13 -0400
X-MC-Unique: uZapHAt1OfiiQ1oCk2oVOg-1
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-5a7c97d5d5aso105437557b3.3
        for <linux-fpga@vger.kernel.org>; Wed, 18 Oct 2023 08:40:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697643612; x=1698248412;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CZEA4k3kA7HlbpTDUQc76jRVTB9sGHxQtfYQNxiSXx8=;
        b=paT/tvoiCJ0p80MLLvoxa17aGtuhvQiT5h/2UvzchLnWPx+HRY3wh96NthriIT50J1
         J2vjV/R1rOA92QhNzLJVSSElXv8NjNyYEIMblH9hSJaK7ErW2KRUlQ9qqkIR5OH67P+p
         zk6rqRbmu2kunHHBWhP7QSfqk+zVXv/uchBl9qLHwRB7tyFLIxNC5hWef6aQ2Yh6DEqf
         G9SbqUdeBPTNHiGslk4Po+bs7SUjQCSkTTMeFGRjeO2OxeR+zZmBvUyB6uyAxtPAz6Fo
         8oQedq7Mr3Vt9GbIjlqBAqoLXmJIKrpsrEj2ZYW3yXVid7Xq2bgSX0z801dNvu+vST37
         c2Mw==
X-Gm-Message-State: AOJu0YxCMU7olSmdbFsJHgKnC0Cwh5TDYrxGsD6xyjWnX0gpLpABtb02
        OfoenxZTgO4X2b/EJ4L8zcd2BCH+oCGFPLVT828dBdRKQ9xojaouje3q05pBANrQkHmje0LNwix
        HvV+F/CUNTfi9k5EPGKvP
X-Received: by 2002:a81:4ad5:0:b0:577:a46:26e5 with SMTP id x204-20020a814ad5000000b005770a4626e5mr5908347ywa.31.1697643612353;
        Wed, 18 Oct 2023 08:40:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFvyjHUkK4fQzKwb5AVPJN2nnr+zOakDfV0FEsRw6NcFD5RksZm59exkggtlqwWoMXrN+ZiUQ==
X-Received: by 2002:a81:4ad5:0:b0:577:a46:26e5 with SMTP id x204-20020a814ad5000000b005770a4626e5mr5908332ywa.31.1697643612073;
        Wed, 18 Oct 2023 08:40:12 -0700 (PDT)
Received: from [192.168.9.16] (net-2-34-31-107.cust.vodafonedsl.it. [2.34.31.107])
        by smtp.gmail.com with ESMTPSA id p19-20020a05620a22f300b00777063b89casm44668qki.5.2023.10.18.08.40.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Oct 2023 08:40:11 -0700 (PDT)
Message-ID: <727498ba-8ea8-43b9-847b-0280a2bf94e3@redhat.com>
Date:   Wed, 18 Oct 2023 17:40:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] FPGA Manager changes for 6.6-final
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Xu Yilun <yilun.xu@linux.intel.com>, yilun.xu@intel.com,
        linux-fpga@vger.kernel.org, hao.wu@intel.com, mdf@kernel.org
References: <ZS6hhlvjUcqyv8zL@yilunxu-OptiPlex-7050>
 <2023101730-budding-spree-1471@gregkh>
 <ZS88oHe8T69/Kks7@yilunxu-OptiPlex-7050>
 <2023101825-ligament-undergrad-cc4d@gregkh>
 <e178f915-fc65-48a1-abab-05d1202319a4@redhat.com>
 <2023101848-smith-tastiness-1459@gregkh>
Content-Language: en-US
From:   Marco Pagani <marpagan@redhat.com>
In-Reply-To: <2023101848-smith-tastiness-1459@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org



On 2023-10-18 13:50, Greg KH wrote:
> On Wed, Oct 18, 2023 at 11:39:01AM +0200, Marco Pagani wrote:
>>
>>
>> On 18/10/23 09:50, Greg KH wrote:
>>> On Wed, Oct 18, 2023 at 10:02:08AM +0800, Xu Yilun wrote:
>>>> On Tue, Oct 17, 2023 at 07:17:29PM +0200, Greg KH wrote:
>>>>> On Tue, Oct 17, 2023 at 11:00:22PM +0800, Xu Yilun wrote:
>>>>>> The following changes since commit 6465e260f48790807eef06b583b38ca9789b6072:
>>>>>>
>>>>>>   Linux 6.6-rc3 (2023-09-24 14:31:13 -0700)
>>>>>>
>>>>>> are available in the Git repository at:
>>>>>>
>>>>>>   git://git.kernel.org/pub/scm/linux/kernel/git/fpga/linux-fpga tags/fpga-for-6.6-final
>>>>>>
>>>>>> for you to fetch changes up to 6a935361500a21ef11a82814ee66fc58e59813f7:
>>>>>>
>>>>>>   fpga: Fix memory leak for fpga_region_test_class_find() (2023-10-12 12:59:29 +0800)
>>>>>>
>>>>>> ----------------------------------------------------------------
>>>>>> FPGA Manager changes for 6.6-final
>>>>>>
>>>>>> FPGA KUnit test:
>>>>>>
>>>>>> - Marco's change fixes null-ptr-deref when try_module_get()
>>>>>> - Jinjie's change fixes a memory leak issue
>>>>>>
>>>>>> Intel m10 bmc secure update:
>>>>>>
>>>>>> - Maintainer change from Russ Weight to Peter Colberg
>>>>>>
>>>>>> All patches have been reviewed on the mailing list, and have been in the
>>>>>> last linux-next releases (as part of our fixes branch)
>>>>>>
>>>>>> Signed-off-by: Xu Yilun <yilun.xu@intel.com>
>>>>>>
>>>>>> ----------------------------------------------------------------
>>>>>> Jinjie Ruan (1):
>>>>>>       fpga: Fix memory leak for fpga_region_test_class_find()
>>>>>>
>>>>>> Marco Pagani (4):
>>>>>>       fpga: add helpers for the FPGA KUnit test suites.
>>>>>>       fpga: add a platform driver to the FPGA Manager test suite
>>>>>>       fpga: add a platform driver to the FPGA Bridge test suite
>>>>>>       fpga: add a platform driver to the FPGA Region test suite
>>>>>
>>>>> Why are all of these test suite patches here?  They are not relevant for
>>>>> 6.6-final as they do not resolve anything.
>>>>
>>>> Maybe the subjects indicate no bug fixing, but they fix null-ptr-deref
>>>> issues when modprobe fpga-mgr/bridge/region-test.
>>>
>>> That's not obvious, sorry.  So are the tests broken right now so that
>>> they don't work at all?
>>
>> They were broken only when compiled and run as modules.
> 
> Then forbid the ability to compile them as modules.

I was mistaken. To be more precise, the suites run when using the KUnit
default UML kernel but crashes on other archs unless MODULES=n.

> 
>>>> In fpga-mgr-test, the pdev->dev->driver is not assigned, so when
>>>>
>>>>   fpga_mgr_test_get()->try_module_get(dev->parent->driver->owner)
>>>
>>> That's a horrible line and should be fixed.  How do you know if a device
>>> has a parent, or if that parent has a driver?  You don't, that should be
>>> fixed instead.
>>>
>>> And module_get on a driver pointer is also never a good idea for other
>>> reasons, why is this happening at all?  It shouldn't be needed if the
>>> code is set up properly (i.e. the unloading of a driver will handle the
>>> shutdown and reference counting properly, no need to try to use module
>>> references at all.)
>>
>> You are right, but fixing the fpga core is outside the scope of my patches.
> 
> Which is why I'm not going to take these as you aren't fixing the root
> problem here :)
> 
>> My intent was to improve the test suite by adding fake drivers irrespective
>> of the fpga core quirks. I might try to send an RFC later to improve the
>> fpga core.
>>
>>>
>>>> NULL ptr is referenced.
>>>>
>>>> So do fpga-bridge/region-test.
>>>>
>>>> Patch #1 adds a common helper to generate a platform driver.
>>>
>>> Don't abuse platform devices/drivers like this, this is not a platform
>>> device or driver.  If you really want to do this, use a real driver and
>>> device, not a platform one please.
>>
>> Other test suites, like DRM suites, already use fake platform devices and
>> drivers. Moreover, many real FPGA IPs, like reconfiguration controllers and
>> bridges, are indeed modeled as platform devices. What is the benefit of
>> using a real driver and device?
> 
> Again, please do not abuse platform devices and drivers when they should
> not be used.  I can't catch all abuses, but when I do see them, I do
> object to them.

Could you please elaborate a little more on why using platform drivers
and devices for test cases is an abuse so I can improve the test suite?

> 
> And again, the root problem here isn't even a platform device issue,
> it's a "assuming the parent has a driver and we want to increment a
> module reference" issue.  That's not ok, nor even needed at all.

Thanks,
Marco

