Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB0C64E44CE
	for <lists+linux-fpga@lfdr.de>; Tue, 22 Mar 2022 18:13:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239420AbiCVRNY (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 22 Mar 2022 13:13:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236802AbiCVRNW (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 22 Mar 2022 13:13:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 318138B6D9
        for <linux-fpga@vger.kernel.org>; Tue, 22 Mar 2022 10:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647969113;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FnfZQdkwW5dihtTgqyz06MglxhoHBi2vvWX4st2kjQw=;
        b=S6xxrebNCSRhI2Hj3473pSgOU84csMONj5Hn3+crGaupUgnJNortyeHHZv5oigiuqx/yK1
        dizlCsuimO+Vpd0bmXGNpJXPHtY/FZgG2K+eKClKjXHtVrDFTYM5NAlj85UzLL/Yqnc3bl
        Cw9SsqxeKDMPQjKjY/vlQtAuqy9tw1Q=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-104-yyfQd310NiCo3YgW1xRLGA-1; Tue, 22 Mar 2022 13:11:52 -0400
X-MC-Unique: yyfQd310NiCo3YgW1xRLGA-1
Received: by mail-qv1-f72.google.com with SMTP id z2-20020a056214060200b00440d1bc7815so14045390qvw.1
        for <linux-fpga@vger.kernel.org>; Tue, 22 Mar 2022 10:11:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=FnfZQdkwW5dihtTgqyz06MglxhoHBi2vvWX4st2kjQw=;
        b=VrL9ICxW4qVABhGxAmWKf4IHg/nU7VpW5T6n9Vx2AgCiNB5Z5dap2z90w92a6cEnqA
         W6Lc/6sWxn8HqYRYqzbDExMHoMBtA/d/fKw5aXbzVQaNsZ5Z6Z3Ep6f3q71tWSRbKwcq
         eca5rnlf0C6mIp/nrmtF8HfDHUwxU9MFiiKQqfegLHTzc2QxBEtzpBcOdkm4/xhu1pbt
         eOEtmT03QggBqtEk0CgQ9rzI5wGDPwRckJwoZ7waRhb8lzwhKADhB7lnGpJvU63KgsI8
         O+AGrbd8ey0YZnlpqTKlKnPtZV8J5MzrIBuqF2dphL3hv2jcseDtVB9qZeahiwZYKeM4
         +Alg==
X-Gm-Message-State: AOAM532qrc71jz3L1gurE3QiAl1ANe3U2OjjPmpG6S+I8CNe7lS8PiQR
        6qUFhZ1IpGqG07TAbRsu3GIb7SiLOSfTmBoeQ4FTy/ZjY2EMHv7qxKQx8wN9hFd1nD3+SjD04rc
        GQVSZeh7qKsbOCML37hMzgw==
X-Received: by 2002:a05:622a:1742:b0:2e1:ecf4:900c with SMTP id l2-20020a05622a174200b002e1ecf4900cmr20877240qtk.473.1647969111060;
        Tue, 22 Mar 2022 10:11:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzTqkdeotbR+nVjUJ0XbMNpYDChyjCG9RGlT1P9GYGEPw1eh6FSLHW6zPJa2Fvxl9ybteTx2Q==
X-Received: by 2002:a05:622a:1742:b0:2e1:ecf4:900c with SMTP id l2-20020a05622a174200b002e1ecf4900cmr20877224qtk.473.1647969110797;
        Tue, 22 Mar 2022 10:11:50 -0700 (PDT)
Received: from localhost.localdomain (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id e7-20020a37ac07000000b0067d7cd47af4sm9327602qkm.31.2022.03.22.10.11.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Mar 2022 10:11:50 -0700 (PDT)
Subject: Re: [PATCH v2 1/2] Documentation: fpga: dfl: add PCI Identification
 documentation
To:     matthew.gerlach@linux.intel.com,
        Russ Weight <russell.h.weight@intel.com>
Cc:     hao.wu@intel.com, yilun.xu@intel.com,
        basheer.ahmed.muddebihal@intel.com, mdf@kernel.org, corbet@lwn.net,
        linux-fpga@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, dan.j.williams@intel.com,
        ashok.raj@intel.com, tianfei.zhang@intel.com
References: <20220303003534.3307971-1-matthew.gerlach@linux.intel.com>
 <20220303003534.3307971-2-matthew.gerlach@linux.intel.com>
 <6448f21f-7ce1-d9ce-1048-29aca14f9d3d@redhat.com>
 <bc41bc12-0d88-771f-7e78-4e29361fcfd8@intel.com>
 <alpine.DEB.2.22.394.2203041021240.3408681@rhweight-WRK1>
From:   Tom Rix <trix@redhat.com>
Message-ID: <6c943903-0fb2-324c-5831-d569d53a7a4c@redhat.com>
Date:   Tue, 22 Mar 2022 10:11:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.22.394.2203041021240.3408681@rhweight-WRK1>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


On 3/4/22 10:30 AM, matthew.gerlach@linux.intel.com wrote:
>
>
> On Fri, 4 Mar 2022, Russ Weight wrote:
>
>>
>>
>> On 3/3/22 14:04, Tom Rix wrote:
>>>
>>> On 3/2/22 4:35 PM, matthew.gerlach@linux.intel.com wrote:
>>>> From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
>>>>
>>>> Add documentation on identifying FPGA based PCI cards prompted
>>>> by discussion on the linux-fpga@vger.kernel.org mailing list.
>>>>
>>>> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
>>>> ---
>>>> v2: Introduced in v2.
>>>> ---
>>>>   Documentation/fpga/dfl.rst | 20 ++++++++++++++++++++
>>>>   1 file changed, 20 insertions(+)
>>>>
>>>> diff --git a/Documentation/fpga/dfl.rst b/Documentation/fpga/dfl.rst
>>>> index ef9eec71f6f3..5fb2ca8e76d7 100644
>>>> --- a/Documentation/fpga/dfl.rst
>>>> +++ b/Documentation/fpga/dfl.rst
>>>> @@ -502,6 +502,26 @@ Developer only needs to provide a sub feature 
>>>> driver with matched feature id.
>>>>   FME Partial Reconfiguration Sub Feature driver (see 
>>>> drivers/fpga/dfl-fme-pr.c)
>>>>   could be a reference.
>>>>   +PCI Device Identification
>>>> +================================
>>>> +Since FPGA based PCI cards can be reconfigured to a perform a 
>>>> completely
>>>> +new function at runtime, properly identifying such cards and 
>>>> binding the
>>>> +correct driver can be challenging. In many use cases, deployed 
>>>> FPGA based
>>>> +PCI cards are essentially static and the PCI Product ID and Vendor 
>>>> ID pair
>>>> +is sufficient to identify the card.  The DFL framework helps with the
>>>> +dynamic case of deployed FPGA cards changing at run time by providing
>>>> +more detailed information about card discoverable at runtime.
>>>> +
>>>> +At one level, the DFL on a PCI card describes the function of the 
>>>> card.
>>>> +However, the same DFL could be instantiated on different physical 
>>>> cards.
>>>> +Conversely, different DFLs could be instantiated on the same 
>>>> physical card.
>>>> +Practical management of a cloud containing a heterogeneous set of 
>>>> such cards
>>>> +requires a PCI level of card identification. While the PCI Product 
>>>> ID and
>>>> +Vendor ID may be sufficient to bind the dfl-pci driver, it is 
>>>> expected
>>>> +that FPGA PCI cards would advertise suitable Subsystem ID and 
>>>> Subsystem
>>>> +Vendor ID values. PCI Vital Product Data (VPD) can also be used for
>>>> +more granular information about the board.
>>>
>>> This describes a bit more of the problem, it should describe it wrt 
>>> ofs dev id. The introduction of the ofs dev should be explicitly 
>>> called out as a generic pci id.
>
> The problem I'm describing exists for all FPGA based PCI cards; so I 
> am purposely trying to be abstract as much as possible.
>
>>>
>>> Why couldn't one of the old pci id's be reused ?
>
> Yes, old pci id's could be reused, and people have done just that.  We 
> thought a new PCI ID would minimize confusion with cards that have 
> already been deployed.
>
>>>
>>> How will the subvendor/subid be enforced ?
>
> Subvendor and Subid are managed just like any other PCI card with or 
> without a FPGA.

Reviewing how the kernel uses subvendor and subsystem shows it is not 
widely used.

And when it is, it is used to isolate small variations or hw problems in 
the device, not completely unique cards

There are very few subsytem/subvendor's in pci_id.h, the usual case 
seems to be hardcoded hex.

So there is no enforcement.

I can not see how this generic id would not be abused by vendors nor how 
it would not be confusing to the end users.

Tom

>
>>>
>>> Is the current security manager patchset smart enough to save the 
>>> board from being bricked when a user doesn't look beyond the pci id ?
>>
>> Yes - the security manager is invoked based of DFL feature ID and 
>> revision, and the functionality is differentiated based on the same 
>> information.
>>
>>>
>>> What happens if a board uses this device id but doesn't have a max10 
>>> to do the update ?
>
> If a board doesn't have a max10, then there will be no DFH for a max10 
> in the board's DFLs.  Presumeably, the board would need some update 
> process, and an approprate DFH would be in that board's DFL.
>
>>>
>>> Tom
>>>
>>>> +
>>>>   Location of DFLs on a PCI Device
>>>>   ================================
>>>>   The original method for finding a DFL on a PCI device assumed the 
>>>> start of the
>>>
>>
>>

