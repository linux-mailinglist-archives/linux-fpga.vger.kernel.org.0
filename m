Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D27972036B1
	for <lists+linux-fpga@lfdr.de>; Mon, 22 Jun 2020 14:27:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728139AbgFVM13 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 22 Jun 2020 08:27:29 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:51086 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728137AbgFVM12 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 22 Jun 2020 08:27:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592828846;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=W2h10LpTAvNoSkQ5Wfs3ntSIZK6FE0PEMdGXqFWlN0Y=;
        b=Y4vRIsQnNtDAwuF3Yi/p0dqPKhEL5wrWVvs/SERTYnkwDIcdXSm0l9uh0whU1ZaJKrrj3t
        1uZDZdgW5wB35Bl9vwHOl92ZToLd9oh7hkmFwL3e6LmufjJClt4He8ZlQykS1dvqZE7UC2
        1+nACv3BW1eikgKHIRxFPZZBGAr/x8k=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-435-_WZCwHR1NlqAp-h7Q2Xjzg-1; Mon, 22 Jun 2020 08:27:23 -0400
X-MC-Unique: _WZCwHR1NlqAp-h7Q2Xjzg-1
Received: by mail-qk1-f197.google.com with SMTP id h18so12747390qkj.13
        for <linux-fpga@vger.kernel.org>; Mon, 22 Jun 2020 05:27:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=W2h10LpTAvNoSkQ5Wfs3ntSIZK6FE0PEMdGXqFWlN0Y=;
        b=WWFeLvQR0h+qOTG8iiQHubGAeLu4Hh7YDOraNHsBte+dqiBm6RDGP4vUkTLya7X284
         Mp4VZxQQxDYlNFu8f/b9QMcM7Z01TxBbj5XBbqJZC+H9JXTaIonIv1EOQh5Si9YXCNYS
         wl3RfyNaAFyNz6lXDfBW7y4s+yHvAVKnONVgi+kjprbB7CAHFzO1iA5VALu7zvZwU0P0
         QRfP5PqJdjPSbCSbTMwgVPw3YqDC/S9Sk/Rnfteqw41m7gWjnrNexXLRErt9SqCm3R96
         LOnO50BmrhPpR6/Qkz8KnHtEcNd0PGKhljId+/EGgYVL4XtcZnap4AGhICeEMQ99LOgz
         S9gA==
X-Gm-Message-State: AOAM531PIPA4hRzb95hGscC6SY2Nfunf2k5g9CVY25tSKw+jzsHSV6Z2
        gGILI0kG9IhAQHMnAs0N9M0TdOLPxfCpDmJWVWzU3cdSACpTv3meaArIu0B0wh/D6/1O2gwyUVx
        G5x+ZOj5ISs1HVkENiV/Z6w==
X-Received: by 2002:a37:57c3:: with SMTP id l186mr15256196qkb.498.1592828843116;
        Mon, 22 Jun 2020 05:27:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwqVS/BGYYFeq6hAqLQIa8xxrqgAC/n0blfyZ/3TKrhs1/dEQRePf7h+6AbOmI33MYNzXvvAA==
X-Received: by 2002:a37:57c3:: with SMTP id l186mr15256181qkb.498.1592828842808;
        Mon, 22 Jun 2020 05:27:22 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id b196sm4114868qkg.11.2020.06.22.05.27.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jun 2020 05:27:22 -0700 (PDT)
Subject: Re: [PATCH v7 0/7] Add interrupt support to FPGA DFL drivers
To:     Xu Yilun <yilun.xu@intel.com>, mdf@kernel.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     bhu@redhat.com, mtosatti@redhat.com, gregkh@linuxfoundation.org,
        jun.j.tian@intel.com, hao.wu@intel.com
References: <1592280528-6350-1-git-send-email-yilun.xu@intel.com>
 <20200622064806.GA5101@yilunxu-OptiPlex-7050>
From:   Tom Rix <trix@redhat.com>
Message-ID: <c9a33ee6-67f2-36b8-0870-ebc038b929ce@redhat.com>
Date:   Mon, 22 Jun 2020 05:27:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200622064806.GA5101@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

In addition to reviewing, I have run these changes on the pac a10 card and while i do not have an afu using interrupts, I have exercised some of the new interfaces.

The most useful i have submitted to selftests drivers/fpga.  In the future, this would be a good place to put other fpga unit tests. 

The selftest patch depends on this change.

So you can also add

Tested-by: Tom Rix <trix@redhat.com>

Tom

On 6/21/20 11:48 PM, Xu Yilun wrote:
> Hi Moritz:
>
> Could you please help review the patchset when you have time?
>
> You have already reviewed the first 3 patches some time ago. The
> comments are all fixed. Hao and Redhat guys also have done several
> rounds of review. The patches are all Acked-by Hao, reviewed by
> Marcelo & Tom.
>
> There is little change to the code for several months, seems it stays
> ready and just need your final Ack.
>
> Actually this is the last feature for our first generation PAC A10 Card,
> and is important for users to have the full support.
>
> We really need your help on code review ...
>
> Many thanks!
> Yilun
>
> On Tue, Jun 16, 2020 at 12:08:41PM +0800, Xu Yilun wrote:
>> This patchset add interrupt support to FPGA DFL drivers.
>>
>> With these patches, DFL driver will parse and assign interrupt resources
>> for enumerated feature devices and their sub features.
>>
>> This patchset also introduces a set of APIs for user to monitor DFL
>> interrupts. Three sub features (DFL FME error, DFL AFU error and user
>> interrupt) drivers now support these APIs.
>>
>> Patch #1: DFL framework change. Accept interrupt info input from DFL bus
>>           driver, and add interrupt parsing and assignment for feature
>>           sub devices.
>> Patch #2: DFL pci driver change, add interrupt info on DFL enumeration.
>> Patch #3: DFL framework change. Add helper functions for feature sub
>>           device drivers to handle interrupt and notify users.
>> Patch #4: Add interrupt support for AFU error reporting sub feature.
>> Patch #5: Add interrupt support for FME global error reporting sub
>>           feature.
>> Patch #6: Add interrupt support for a new sub feature, to handle user
>>           interrupts implemented in AFU.
>> Patch #7: Documentation for DFL interrupt handling.
>>
>> Main changes from v1:
>>  - Early validating irq table for each feature in parse_feature_irq()
>>    in Patch #1.
>>  - Changes IOCTL interfaces. use DFL_FPGA_FME/PORT_XXX_GET_IRQ_NUM
>>    instead of DFL_FPGA_FME/PORT_XXX_GET_INFO, delete flag field for
>>    DFL_FPGA_FME/PORT_XXX_SET_IRQ param
>>
>> Main changes from v2:
>>  - put parse_feature_irqs() inside create_feature_instance().
>>  - refines code for dfl_fpga_set_irq_triggers, delete local variable j.
>>  - put_user() instead of copy_to_user() for DFL_FPGA_XXX_GET_IRQ_NUM IOCTL
>>
>> Main changes from v3:
>>  - rebased to 5.7-rc1.
>>  - fail the dfl enumeration when irq parsing error happens.
>>  - Add 2 helper functions in dfl.c to handle generic irq ioctls in feature
>>    drivers.
>>
>> Main changes from v4:
>>  - Minor fixes for Hao's comments.
>>
>> Main changes from v5:
>>  - Remove unnecessary type casting in Patch #1 & #3.
>>  - Minor fixes for Moritz's comments.
>>
>> Main changes from v6:
>>  - Add the header file <linux/interrupt.h> for Patch #1, to fix build
>>    error on ARCH=xtensa
>>  - Minor fixes in Patch #2 & #3.
>>
>> Xu Yilun (7):
>>   fpga: dfl: parse interrupt info for feature devices on enumeration
>>   fpga: dfl: pci: add irq info for feature devices enumeration
>>   fpga: dfl: introduce interrupt trigger setting API
>>   fpga: dfl: afu: add interrupt support for port error reporting
>>   fpga: dfl: fme: add interrupt support for global error reporting
>>   fpga: dfl: afu: add AFU interrupt support
>>   Documentation: fpga: dfl: add descriptions for interrupt related
>>     interfaces.
>>
>>  Documentation/fpga/dfl.rst    |  19 +++
>>  drivers/fpga/dfl-afu-error.c  |  17 +++
>>  drivers/fpga/dfl-afu-main.c   |  32 +++++
>>  drivers/fpga/dfl-fme-error.c  |  18 +++
>>  drivers/fpga/dfl-fme-main.c   |   6 +
>>  drivers/fpga/dfl-pci.c        |  76 +++++++++--
>>  drivers/fpga/dfl.c            | 310 ++++++++++++++++++++++++++++++++++++++++++
>>  drivers/fpga/dfl.h            |  57 ++++++++
>>  include/uapi/linux/fpga-dfl.h |  82 +++++++++++
>>  9 files changed, 608 insertions(+), 9 deletions(-)
>>
>> -- 
>> 2.7.4

