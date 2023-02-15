Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FB64697A94
	for <lists+linux-fpga@lfdr.de>; Wed, 15 Feb 2023 12:21:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232952AbjBOLT6 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 15 Feb 2023 06:19:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232865AbjBOLT4 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 15 Feb 2023 06:19:56 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2765367D5
        for <linux-fpga@vger.kernel.org>; Wed, 15 Feb 2023 03:19:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676459949;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PpXRm7XIkaSeK+VtCKb2B+xrc7DWzyzfV1s6qUfwQhA=;
        b=ivdY3DGefsy07LrJ7U7NG1qyYoiiF6db2P4xc5NfpdnhLeB6PVGe7KFYH21hfj0X7fgetK
        pfTexWigff2cDB7SUdU76kAd+dvdGUq7EBlcqWjnANXJcBrOp9m4XsPsVTvmqXwHbfuH0F
        myAkK8ji/NNZfVml+I2DXqYoR7jx/Js=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-619-PdSvQf7XODewmRU4w_U7Yg-1; Wed, 15 Feb 2023 06:19:08 -0500
X-MC-Unique: PdSvQf7XODewmRU4w_U7Yg-1
Received: by mail-qk1-f199.google.com with SMTP id x14-20020a05620a14ae00b0072f7f0f356bso11193100qkj.1
        for <linux-fpga@vger.kernel.org>; Wed, 15 Feb 2023 03:19:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PpXRm7XIkaSeK+VtCKb2B+xrc7DWzyzfV1s6qUfwQhA=;
        b=b1IO6/hq0B7EzeFWGQsI81u2YEERv7cQc569OQzPJ2EVENvdTm4grCEbDKcma//esd
         hoQJueEFpJR6fF97fT7qzez7SEqL2Df+fT5yrZq3SVOZ+KJvK2d+md7iU3iEnNxfT9jU
         aPSpz882CJKIHquAD+qIQFzeQ3CX8JaSuhXZ551JiHiXiXwuW9mddhws/lid0CodytAJ
         fNMtShom5qsIgc7GMh1jB3KyDTslmbF1ZUrfQjP30renLqoHq+UCzg4WvrEDMJIgnru5
         aHd1ol921Y7dSWAQeSpWJLgg1klHafTjbFExzdgWn+KFHr9OTU8ybIcFP1/ORjJyYXgz
         52TA==
X-Gm-Message-State: AO0yUKVR3ajpwuFDleENHrhCS8VwfnigjtlIi/ULrU6f4JGp806uT/Nf
        ppHtRplPeTxlyAgk4q15KVfr8RKnkVx6VK3WsUxKOfxDlKXjizKVZQYzQunF49aGoq0EPib6hXJ
        XbuSsBCDUUX98oW4/daDijO8gyQ==
X-Received: by 2002:a05:622a:178e:b0:3b8:118d:ad86 with SMTP id s14-20020a05622a178e00b003b8118dad86mr2605458qtk.21.1676459947248;
        Wed, 15 Feb 2023 03:19:07 -0800 (PST)
X-Google-Smtp-Source: AK7set8ODu25/O65aN32Wt/bDc0IqdTcumQhtlrKFUM/TMBauFfneJFeRapdQxu8kPlHYEvCbGZFyg==
X-Received: by 2002:a05:622a:178e:b0:3b8:118d:ad86 with SMTP id s14-20020a05622a178e00b003b8118dad86mr2605436qtk.21.1676459946971;
        Wed, 15 Feb 2023 03:19:06 -0800 (PST)
Received: from [192.168.9.16] (net-2-34-30-183.cust.vodafonedsl.it. [2.34.30.183])
        by smtp.gmail.com with ESMTPSA id y16-20020ac85f50000000b003ba1ccba523sm13085361qta.93.2023.02.15.03.19.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Feb 2023 03:19:06 -0800 (PST)
Message-ID: <01fd3850-af54-c0f0-ec2f-ae672420ce17@redhat.com>
Date:   Wed, 15 Feb 2023 12:19:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [RFC PATCH 0/4] fpga: add initial KUnit test suite for the
 subsystem
Content-Language: en-US
To:     Russ Weight <russell.h.weight@intel.com>
Cc:     Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
        linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org
References: <20230203170653.414990-1-marpagan@redhat.com>
 <05f6238e-4ad8-f30c-38da-74c343e6abb5@intel.com>
From:   Marco Pagani <marpagan@redhat.com>
In-Reply-To: <05f6238e-4ad8-f30c-38da-74c343e6abb5@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org



On 2023-02-14 02:20, Russ Weight wrote:
> 
> 
> On 2/3/23 09:06, Marco Pagani wrote:
>> This patch set introduces a KUnit suite to test the core components
>> of the FPGA subsystem. More specifically, the suite tests the core
>> functions of the FPGA manager, FPGA bridge, and FPGA region.
>>
>> These components are tested using "fake" modules that allow
>> observing their internals without altering the source code.
>>
>> The test suite can be run using
>> [user@localhost linux]$ ./tools/testing/kunit/kunit.py run --kunitconfig=drivers/fpga/tests
> When I tried running these tests, I got an error until I created this file:
> 
> drivers/fpga/tests/.kunitconfig:
> CONFIG_KUNIT=y
> CONFIG_FPGA=y
> CONFIG_FPGA_REGION=y
> CONFIG_FPGA_BRIDGE=y
> CONFIG_FPGA_KUNIT_TESTS=y
> 
> I think this file needs to be included in your patchset?
> 
> - Russ
>


Patch 1/4 includes a .kunitconfig file with these configs set =y

> diff --git a/drivers/fpga/tests/.kunitconfig b/drivers/fpga/tests/.kunitconfig
> new file mode 100644
> index 000000000000..a1c2a2974c39
> --- /dev/null
> +++ b/drivers/fpga/tests/.kunitconfig
> @@ -0,0 +1,5 @@
> +CONFIG_KUNIT=y
> +CONFIG_FPGA=y
> +CONFIG_FPGA_REGION=y
> +CONFIG_FPGA_BRIDGE=y
> +CONFIG_FPGA_KUNIT_TESTS=y

To double-check for any patch format errors, I downloaded the patch set
from lore.kernel.org and applied it on a fresh tree with Git (version
2.39.1) using git am. In my case, Git created the .kunitconfig file and
I was able to run the tests.


>>
>> Marco Pagani (4):
>>   fpga: add initial KUnit test suite
>>   fpga: add fake FPGA region
>>   fpga: add fake FPGA manager
>>   fpga: add fake FPGA bridge
>>
>>  drivers/fpga/Kconfig                  |   2 +
>>  drivers/fpga/Makefile                 |   3 +
>>  drivers/fpga/tests/.kunitconfig       |   5 +
>>  drivers/fpga/tests/Kconfig            |  15 ++
>>  drivers/fpga/tests/Makefile           |   6 +
>>  drivers/fpga/tests/fake-fpga-bridge.c | 214 +++++++++++++++
>>  drivers/fpga/tests/fake-fpga-bridge.h |  36 +++
>>  drivers/fpga/tests/fake-fpga-mgr.c    | 365 ++++++++++++++++++++++++++
>>  drivers/fpga/tests/fake-fpga-mgr.h    |  42 +++
>>  drivers/fpga/tests/fake-fpga-region.c | 186 +++++++++++++
>>  drivers/fpga/tests/fake-fpga-region.h |  37 +++
>>  drivers/fpga/tests/fpga-tests.c       | 264 +++++++++++++++++++
>>  12 files changed, 1175 insertions(+)
>>  create mode 100644 drivers/fpga/tests/.kunitconfig
>>  create mode 100644 drivers/fpga/tests/Kconfig
>>  create mode 100644 drivers/fpga/tests/Makefile
>>  create mode 100644 drivers/fpga/tests/fake-fpga-bridge.c
>>  create mode 100644 drivers/fpga/tests/fake-fpga-bridge.h
>>  create mode 100644 drivers/fpga/tests/fake-fpga-mgr.c
>>  create mode 100644 drivers/fpga/tests/fake-fpga-mgr.h
>>  create mode 100644 drivers/fpga/tests/fake-fpga-region.c
>>  create mode 100644 drivers/fpga/tests/fake-fpga-region.h
>>  create mode 100644 drivers/fpga/tests/fpga-tests.c
>>
> 

Thanks,
Marco

