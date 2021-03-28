Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBCEE34BCF9
	for <lists+linux-fpga@lfdr.de>; Sun, 28 Mar 2021 17:41:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230411AbhC1Pkj (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 28 Mar 2021 11:40:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:30517 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230350AbhC1Pkb (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Sun, 28 Mar 2021 11:40:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616946030;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5z7V6RMJruOPYGOOMVsLphcjB1pcPNdGrCDqwJRavuY=;
        b=Isn28Wt0Vf0/SfFNyisS/zdanvN+XmNEPrfxFrhhY+JAosl4ZfAfPRPOBER8L38iZQcUDv
        QLC5LE+RfRxGra/Cj5eIe2E/mNaWdZuhQlrSO9FrTlS1hinCkOccQpTrd4S2XO74i28SDU
        CUm0YSxw4oL8uJB1KBNaKWeuKvuWgFI=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-350-swUxMuFyNemF5wFeUwws3w-1; Sun, 28 Mar 2021 11:40:28 -0400
X-MC-Unique: swUxMuFyNemF5wFeUwws3w-1
Received: by mail-qk1-f197.google.com with SMTP id h21so10418748qkl.12
        for <linux-fpga@vger.kernel.org>; Sun, 28 Mar 2021 08:40:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=5z7V6RMJruOPYGOOMVsLphcjB1pcPNdGrCDqwJRavuY=;
        b=N9syWAvQWKePnUwAiOx03Mq8YvmKK5S9EuNryf9c/rzQg97lBn0qlN6aGM/wRuZjTp
         7wEdQNrQvbSsZAK/fzeygnMzb+FzDXUDeaInGIFCSVKoGWFUSCvp9PEB1myN/d/vK2Md
         e/ltsmnSZWDrwHQUojVw+mNMQIEtfgE39RKc02NbIhlypsvtBJHqeAG/2+MWq9eNVJmz
         JmsNBJOjEGypQk41wiYija5ceUAmggW4+AdsVEgjAOHOcBeldslFiJ7zMr/WVnODD/yv
         3RhOH4TLWtMh/hNedh/humvAXnOy71mvMMJRqjw5devl4wPfXneBb7ouZ/NF0pcDzElv
         hYzg==
X-Gm-Message-State: AOAM530XHp3objSz+HIpQN3t4oAkwjcL8+WrQYBnCCE/PIS+Be56oPdU
        prrHi0whhcHQGVDjTtEnp1mN1NH5HG9vyzw8KgZ2mIcitARwJzem6HcFuN+BB++VgurisgqNFOD
        PVY/9lklcOdjZEw4ycXz6zw==
X-Received: by 2002:ad4:4ae9:: with SMTP id cp9mr21652786qvb.20.1616946028428;
        Sun, 28 Mar 2021 08:40:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwFBc8Qm2TQ02HNWSRarsKCjaJstalRLV+3PsjWHocmYdSDvb0XjRrobeb45TpK8NxzubiTtw==
X-Received: by 2002:ad4:4ae9:: with SMTP id cp9mr21652773qvb.20.1616946028243;
        Sun, 28 Mar 2021 08:40:28 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id o197sm10829852qka.26.2021.03.28.08.40.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Mar 2021 08:40:27 -0700 (PDT)
Subject: Re: [PATCHv5 0/7] Extend Intel service layer, FPGA manager and region
To:     Moritz Fischer <mdf@kernel.org>,
        "Gong, Richard" <richard.gong@intel.com>
Cc:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "richard.gong@linux.intel.com" <richard.gong@linux.intel.com>,
        russell.h.weight@intel.com
References: <1612909233-13867-1-git-send-email-richard.gong@linux.intel.com>
 <MWHPR11MB001577B17723C8A046398249879E9@MWHPR11MB0015.namprd11.prod.outlook.com>
 <YF90y3Di4RbuJvr0@epycbox.lan>
From:   Tom Rix <trix@redhat.com>
Message-ID: <496aa871-cfb0-faf4-4b1c-b53e56b58030@redhat.com>
Date:   Sun, 28 Mar 2021 08:40:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <YF90y3Di4RbuJvr0@epycbox.lan>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


On 3/27/21 11:09 AM, Moritz Fischer wrote:
> Hi Richard, Russ,
>
> On Thu, Feb 25, 2021 at 01:07:14PM +0000, Gong, Richard wrote:
>> Hi Moritz,
>>
>> Sorry for asking.
>>
>> When you have chance, can you help review the version 5 patchset submitted on 02/09/21?
>>
>> Regards,
>> Richard
>>
>> -----Original Message-----
>> From: richard.gong@linux.intel.com <richard.gong@linux.intel.com> 
>> Sent: Tuesday, February 9, 2021 4:20 PM
>> To: mdf@kernel.org; trix@redhat.com; gregkh@linuxfoundation.org; linux-fpga@vger.kernel.org; linux-kernel@vger.kernel.org
>> Cc: Gong, Richard <richard.gong@intel.com>
>> Subject: [PATCHv5 0/7] Extend Intel service layer, FPGA manager and region
>>
>> From: Richard Gong <richard.gong@intel.com>
>>
>> This is 5th submission of Intel service layer and FPGA patches, which includes the missing standalone patch in the 4th submission.
>>
>> This submission includes additional changes for Intel service layer driver to get the firmware version running at FPGA SoC device. Then FPGA manager driver, one of Intel service layer driver's client, can decide whether to handle the newly added bitstream authentication function based on the retrieved firmware version. So that we can maintain FPGA manager driver the back compatible.
>>
>> Bitstream authentication makes sure a signed bitstream has valid signatures.
>>
>> The customer sends the bitstream via FPGA framework and overlay, the firmware will authenticate the bitstream but not program the bitstream to device. If the authentication passes, the bitstream will be programmed into QSPI flash and will be expected to boot without issues.
>>
>> Extend Intel service layer, FPGA manager and region drivers to support the bitstream authentication feature. 
>>
>> Richard Gong (7):
>>   firmware: stratix10-svc: reset COMMAND_RECONFIG_FLAG_PARTIAL to 0
>>   firmware: stratix10-svc: add COMMAND_AUTHENTICATE_BITSTREAM flag
>>   firmware: stratix10-svc: extend SVC driver to get the firmware version
>>   fpga: fpga-mgr: add FPGA_MGR_BITSTREAM_AUTHENTICATE flag
>>   fpga: of-fpga-region: add authenticate-fpga-config property
>>   dt-bindings: fpga: add authenticate-fpga-config property
>>   fpga: stratix10-soc: extend driver for bitstream authentication
>>
>>  .../devicetree/bindings/fpga/fpga-region.txt       | 10 ++++
>>  drivers/firmware/stratix10-svc.c                   | 12 ++++-
>>  drivers/fpga/of-fpga-region.c                      | 24 ++++++---
>>  drivers/fpga/stratix10-soc.c                       | 62 +++++++++++++++++++---
>>  include/linux/firmware/intel/stratix10-smc.h       | 21 +++++++-
>>  .../linux/firmware/intel/stratix10-svc-client.h    | 11 +++-
>>  include/linux/fpga/fpga-mgr.h                      |  3 ++
>>  7 files changed, 125 insertions(+), 18 deletions(-)
>>
>> --
>> 2.7.4
>>
> Apologies for the epic delay in getting back to this, I took another
> look at this patchset and Russ' patchset.
>
> TL;DR I'm not really a fan of using device-tree overlays for this (and
> again, apologies, I should've voiced this earlier ...).
>
> Anyways, let's find a common API for this and Russ' work, they're trying
> to achieve the same / similar thing, they should use the same API.
>
> I'd like to re-invetigate the possiblity to extend FPGA Manager with
> 'secure update' ops that work for both these use-cases (and I susspect
> hte XRT patchset will follow with a similar requirement, right after).

The xrt patchset makes heavy use of device trees.

What is the general guidance for device tree usage ?

Tom

>
> - Moritz
>

