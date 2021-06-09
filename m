Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 378A93A1D35
	for <lists+linux-fpga@lfdr.de>; Wed,  9 Jun 2021 20:52:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229507AbhFISyt (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 9 Jun 2021 14:54:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27143 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229472AbhFISys (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 9 Jun 2021 14:54:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623264771;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UJv7aWmnObYZjIRak2zuvQQ+UDBG4ApcHE+EP2bUvao=;
        b=GJr4rohL7ov7w2kyw7Px4y1AUjlHpwsVGMq9xIUad/6iNI91ADaucs9JDXNEjmFMIYDDD5
        RCGYXuEruMiE6f9XkSOUgyy8FYTyPUzbUfDrpUa3Na/6HjSUPNux9dgWSZkhqZY2Nv8q7O
        d+3d8nZ2TbrJs0uMWdlv/nEuYLHinSQ=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-417-Sy34K9PwOLmazPgxuIyWTA-1; Wed, 09 Jun 2021 14:52:50 -0400
X-MC-Unique: Sy34K9PwOLmazPgxuIyWTA-1
Received: by mail-oo1-f71.google.com with SMTP id l13-20020a4aa78d0000b0290245c8f11ac2so16064468oom.11
        for <linux-fpga@vger.kernel.org>; Wed, 09 Jun 2021 11:52:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=UJv7aWmnObYZjIRak2zuvQQ+UDBG4ApcHE+EP2bUvao=;
        b=KCVzdhyRMy78FgvpkEOWOG/oIv+Rys0sfBCdkXZUSJbQWFWfzqb1toiXSJVhvzRA9c
         jnGEq9GxmcxYmQunT/I25clckQBHXW8q305XV370vHvivk3Tn9vPfVUJKpB75d9VYozC
         8goojWxT72cdIQh102HQSxbNesUY9eWReUy83MdpqKNYDRiCgXsQF2QDe7nHv0thpdA+
         TUV0hIctE2PhQIFxqm/3WyY0mJBeScmlc8BoDXamRgAwmxM0hnDXnnYjnmh9gW9DWd8x
         x7vESRrIuVLlktu28AknB57e6XCt6YHhXcm42yF8a4uoWY5VZSGGvzLyYF9feu4vEONA
         kKhg==
X-Gm-Message-State: AOAM530lf4fe7uMZg1FxQeTQW3+BrVoaheo8n5OsZucJPpMTmET6ce/E
        RNaoG4XjFU4O8Dkwsesh6kKJuPbtDNcMqDfxz0maPzQ2XE329kMRxtz/YyPsIXVmtoneeKSYH3U
        bPvbd/ZC6PGAWhoknSVaCww==
X-Received: by 2002:a9d:1b41:: with SMTP id l59mr752434otl.8.1623264769457;
        Wed, 09 Jun 2021 11:52:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzbksmEZVttdsFOTiUH5FxL4Xn997V4wIynWP3Ez8EQZC2AnipQtQmYRnCULF/30XC2+WXccw==
X-Received: by 2002:a9d:1b41:: with SMTP id l59mr752409otl.8.1623264769221;
        Wed, 09 Jun 2021 11:52:49 -0700 (PDT)
Received: from localhost.localdomain (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id q26sm117297ood.7.2021.06.09.11.52.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Jun 2021 11:52:48 -0700 (PDT)
Subject: Re: [PATCH v2 0/4] fpga: reorganize to subdirs
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     mdf@kernel.org, hao.wu@intel.com, michal.simek@xilinx.com,
        nava.manne@xilinx.com, dinguyen@kernel.org,
        krzysztof.kozlowski@canonical.com, yilun.xu@intel.com,
        arnd@arndb.de, fpacheco@redhat.com, richard.gong@intel.com,
        luca@lucaceresoli.net, linux-kernel@vger.kernel.org,
        linux-fpga@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20210609142208.3085451-1-trix@redhat.com>
 <YMDV7R52QUTFhpHH@kroah.com>
 <2738ee7a-448f-c327-c430-13fb44da45ec@redhat.com>
 <YMDueTEHGWuAcknP@kroah.com>
 <a35f5fda-a202-dc66-4445-b3ce333a55e6@redhat.com>
 <YMD2yxtsQN16MoPA@kroah.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <aba774cb-1135-26aa-6e20-3c00b4e269ac@redhat.com>
Date:   Wed, 9 Jun 2021 11:52:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YMD2yxtsQN16MoPA@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


On 6/9/21 10:13 AM, Greg KH wrote:
> On Wed, Jun 09, 2021 at 09:50:39AM -0700, Tom Rix wrote:
>> On 6/9/21 9:38 AM, Greg KH wrote:
>>> On Wed, Jun 09, 2021 at 08:08:06AM -0700, Tom Rix wrote:
>>>> On 6/9/21 7:53 AM, Greg KH wrote:
>>>>> On Wed, Jun 09, 2021 at 07:22:03AM -0700, trix@redhat.com wrote:
>>>>>> From: Tom Rix <trix@redhat.com>
>>>>>>
>>>>>> The incoming xrt patchset has a toplevel subdir xrt/
>>>>>> The current fpga/ uses a single dir with filename prefixes to subdivide owners
>>>>>> For consistency, there should be only one way to organize the fpga/ dir.
>>>>>> Because the subdir model scales better, refactor to use it.
>>>>>> The discussion wrt xrt is here:
>>>>>> https://lore.kernel.org/linux-fpga/68e85a4f-4a10-1ff9-0443-aa565878c855@redhat.com/
>>>>>>
>>>>>> Follow drivers/net/ethernet/ which has control configs
>>>>>> NET_VENDOR_BLA that map to drivers/net/ethernet/bla
>>>>>> Since fpgas do not have many vendors, drop the 'VENDOR' and use
>>>>>> FPGA_BLA.
>>>>>>
>>>>>> There are several new subdirs
>>>>>> altera/
>>>>>> dfl/
>>>>>> lattice/
>>>>>> xilinx/
>>>>>>
>>>>>> Each subdir has a Kconfig that has a new/reused
>>>>>>
>>>>>> if FPGA_BLA
>>>>>>      ... existing configs ...
>>>>>> endif FPGA_BLA
>>>>>>
>>>>>> Which is sourced into the main fpga/Kconfig
>>>>>>
>>>>>> Each subdir has a Makefile whose transversal is controlled in the
>>>>>> fpga/Makefile by
>>>>>>
>>>>>> obj-$(CONFIG_FPGA_BLA) += bla/
>>>>>>
>>>>>> Some cleanup to arrange thing alphabetically and make fpga/Makefile's
>>>>>> whitespace look more like net/'s
>>>>>>
>>>>>> Changes from
>>>>>> v1
>>>>>>      Drop renaming files
>>>>>>      Cleanup makefiles
>>>>> You can rename the files, you just can not rename the .ko objects
>>>>> without everyone knowing what you are doing and you trying to bury it in
>>>>> the middle of a differently described patch.
>>>>>
>>>>> If you want to do that, do you?  I don't really understand why you want
>>>>> to move things around right now other than "we have 40 files in one
>>>>> directory, ick!".
>>>> I am trying to resolve the layout inconsistency between what we have and
>>>> what the xrt patchset does.
>>> Why does it matter?  New stuff can be added to a new dir, why worry
>>> about old stuff?  What does it hurt?
>>>
>>>> The big issue is the files vs dirs.
>>>>
>>>> Over specified filenames is secondary, so I dropped them.
>>>>
>>>> 40 files in one dir is itself not a problem.
>>>>
>>>> having 40 files and an xrt/ is.
>>> Why is that a "problem"?
>>>
>>>> fpga/ layout should be consistent so the Makefile and Kconfig are easier to
>>>> maintain.
>>> Is it somehow hard to maintain today?  Seems pretty trivial to me...
>> This change was to help move xrt along.
>>
>> If you are fine with xrt/, I will drop this patchset.
> Who has objected to xrt/ being the only new subdirectory?

Maybe just me, but it has been mostly me doing the review.

all of my easy comments have been nearly resolved.

now I am looking at bigger issues like this, should subdev's move out of 
fpga/ etc.

>
> My main complaints here are:
> 	- these patches were not tested
> 	- you renamed kernel modules "accidentally"
> 	- you forgot SPDX lines
> 	- lack of description of why these files being moved was
> 	  necessary in the changelog where you moved the files
>
> Remember, patch 0/X never shows up in changelogs...

I will respin and collapse the patches to a single patch with a better 
commit log.

They aren't really useful except as a full change.

Testing will be done for dfl.

Tom

>
> You can do better :)
>
> greg k-h
>

