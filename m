Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C46677BDAAC
	for <lists+linux-fpga@lfdr.de>; Mon,  9 Oct 2023 14:06:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346412AbjJIMEZ (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 9 Oct 2023 08:04:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346375AbjJIMEZ (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 9 Oct 2023 08:04:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26AD2C6
        for <linux-fpga@vger.kernel.org>; Mon,  9 Oct 2023 05:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696853013;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Po//LtwVWhPkCviDSMY4CfdRlRJZDKBuNSSZsFwV2AE=;
        b=Geh8cX5q1YTBSoHF8lfN1POBXXWDahm/eCe1TAdO4A14PAphUCKDWC5IDDJ2SMEKGuyAXd
        Gtjww2tO7WfnXFtalNlFsHo3yDtYtaDyqiRs0iTWX8qm7dJDcPs49aBTICOtRxGWPIw9ty
        3A6iKvBdrkOQZDR5CCAw1PX/gIET8Is=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-231-dj5Nogr7Ne2n65kQgqBhGg-1; Mon, 09 Oct 2023 08:03:22 -0400
X-MC-Unique: dj5Nogr7Ne2n65kQgqBhGg-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-775d995f92aso604743885a.1
        for <linux-fpga@vger.kernel.org>; Mon, 09 Oct 2023 05:03:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696853001; x=1697457801;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Po//LtwVWhPkCviDSMY4CfdRlRJZDKBuNSSZsFwV2AE=;
        b=psvfQTNwJjWMe/GeXwSOhK8ULP7rzEKe7G/q0nUOrIGFO/12uRqZ+BszZ10Q/Qd0Jn
         Wcj+7atPWS03Hp6EnmgVxd3Ts9rrrX9AoBpchJ7McExGBuE7FTt0GWY7VSnNqNZPoFcR
         +zeCFLvrV/w6GSzvlY98mLi3Dq8bWMwZnAgZRPxJZuVqR5R8do69OYfO1q5AynEIPCf3
         4FCojiEPT+Z2U1O9nVyR5MDtDlmEXOTgfd8+W3MGRDgogjhcCy3sIxrnh6C4DxbA0AMB
         +sjcGT1Cl4EzBL3hlvkN1nlwZBlMjMFe1Swi4s4VO0Ji+h586O2zm4zhBAhMakRX7daf
         OK1w==
X-Gm-Message-State: AOJu0YxKi5wNOJFj0kXQvu9pZ7sXu4QF8rK+lE9xYSb93rlm1I/b2fv0
        zBC2dk2eks95YY8MVo1aCtqYJFFCyGvEB11CqAP+kRhVBegaN2TE2n5OZ8mP1tqUP9Pn/lPgaAC
        U8Bio8x1rdz1mSA+V3nsw9A52LdxH
X-Received: by 2002:ad4:5c85:0:b0:656:55f8:e82 with SMTP id o5-20020ad45c85000000b0065655f80e82mr24422691qvh.32.1696853001420;
        Mon, 09 Oct 2023 05:03:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFHRiahAWk7KpgMlP0WQmbw+lZNWnVzwmWYPDR1kUDb21kQ4+bKT6AjI92gYAa6TrOcCY5WNQ==
X-Received: by 2002:ad4:5c85:0:b0:656:55f8:e82 with SMTP id o5-20020ad45c85000000b0065655f80e82mr24422668qvh.32.1696853001198;
        Mon, 09 Oct 2023 05:03:21 -0700 (PDT)
Received: from [192.168.9.16] (net-2-34-30-58.cust.vodafonedsl.it. [2.34.30.58])
        by smtp.gmail.com with ESMTPSA id e1-20020a0ce3c1000000b0065d52e04f78sm3773031qvl.97.2023.10.09.05.03.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Oct 2023 05:03:20 -0700 (PDT)
Message-ID: <d14b4c86-8d6b-a9b3-c81a-34f07301cf96@redhat.com>
Date:   Mon, 9 Oct 2023 14:03:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] fpga: Fix memory leak for fpga_region_test_class_find()
To:     Jinjie Ruan <ruanjinjie@huawei.com>
References: <20231007094321.3447084-1-ruanjinjie@huawei.com>
Content-Language: en-US
Cc:     Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>,
        Tom Rix <trix@redhat.com>, Wu Hao <hao.wu@intel.com>,
        linux-fpga@vger.kernel.org
From:   Marco Pagani <marpagan@redhat.com>
In-Reply-To: <20231007094321.3447084-1-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org



On 2023-10-07 11:43, Jinjie Ruan wrote:
> When CONFIG_FPGA_KUNIT_TESTS=m and making CONFIG_DEBUG_KMEMLEAK=y
> and CONFIG_DEBUG_KMEMLEAK_AUTO_SCAN=y, modprobe fpga-region-test and then
> rmmod fpga-region-test, the below memory leak is detected.
> 
> fpga_region_class_find() in fpga_region_test_class_find() will call
> get_device() if the data is matched, which will increment refcount for
> dev->kobj, so it should call put_device() to decrement refcount for
> dev->kobj to free the region, because fpga_region_unregister() will call
> fpga_region_dev_release() only when the refcount for dev->kobj is zero
> but fpga_region_test_init() call device_register() in
> fpga_region_register_full(), which also increment refcount.
> 
> So call put_device() after calling fpga_region_class_find() in
> fpga_region_test_class_find(). After applying this patch, the following

Looks good to me. Thanks.

Reviewed-by: Marco Pagani <marpagan@redhat.com>

> memory leak is never detected.
> 
> unreferenced object 0xffff88810c8ef000 (size 1024):
>   comm "kunit_try_catch", pid 1875, jiffies 4294715298 (age 836.836s)
>   hex dump (first 32 bytes):
>     b8 d1 fb 05 81 88 ff ff 08 f0 8e 0c 81 88 ff ff  ................
>     08 f0 8e 0c 81 88 ff ff 00 00 00 00 00 00 00 00  ................
>   backtrace:
>     [<ffffffff817ebad7>] kmalloc_trace+0x27/0xa0
>     [<ffffffffa02385e1>] fpga_region_register_full+0x51/0x430 [fpga_region]
>     [<ffffffffa0228e47>] 0xffffffffa0228e47
>     [<ffffffff829c479d>] kunit_try_run_case+0xdd/0x250
>     [<ffffffff829c9f2a>] kunit_generic_run_threadfn_adapter+0x4a/0x90
>     [<ffffffff81238b85>] kthread+0x2b5/0x380
>     [<ffffffff81097ded>] ret_from_fork+0x2d/0x70
>     [<ffffffff810034d1>] ret_from_fork_asm+0x11/0x20
> unreferenced object 0xffff888105fbd1b8 (size 8):
>   comm "kunit_try_catch", pid 1875, jiffies 4294715298 (age 836.836s)
>   hex dump (first 8 bytes):
>     72 65 67 69 6f 6e 30 00                          region0.
>   backtrace:
>     [<ffffffff817ec023>] __kmalloc_node_track_caller+0x53/0x150
>     [<ffffffff82995590>] kvasprintf+0xb0/0x130
>     [<ffffffff83f713b1>] kobject_set_name_vargs+0x41/0x110
>     [<ffffffff8304ac1b>] dev_set_name+0xab/0xe0
>     [<ffffffffa02388a2>] fpga_region_register_full+0x312/0x430 [fpga_region]
>     [<ffffffffa0228e47>] 0xffffffffa0228e47
>     [<ffffffff829c479d>] kunit_try_run_case+0xdd/0x250
>     [<ffffffff829c9f2a>] kunit_generic_run_threadfn_adapter+0x4a/0x90
>     [<ffffffff81238b85>] kthread+0x2b5/0x380
>     [<ffffffff81097ded>] ret_from_fork+0x2d/0x70
>     [<ffffffff810034d1>] ret_from_fork_asm+0x11/0x20
> unreferenced object 0xffff88810b3b8a00 (size 256):
>   comm "kunit_try_catch", pid 1875, jiffies 4294715298 (age 836.836s)
>   hex dump (first 32 bytes):
>     00 00 00 00 00 00 00 00 08 8a 3b 0b 81 88 ff ff  ..........;.....
>     08 8a 3b 0b 81 88 ff ff e0 ac 04 83 ff ff ff ff  ..;.............
>   backtrace:
>     [<ffffffff817ebad7>] kmalloc_trace+0x27/0xa0
>     [<ffffffff83056d7a>] device_add+0xa2a/0x15e0
>     [<ffffffffa02388b1>] fpga_region_register_full+0x321/0x430 [fpga_region]
>     [<ffffffffa0228e47>] 0xffffffffa0228e47
>     [<ffffffff829c479d>] kunit_try_run_case+0xdd/0x250
>     [<ffffffff829c9f2a>] kunit_generic_run_threadfn_adapter+0x4a/0x90
>     [<ffffffff81238b85>] kthread+0x2b5/0x380
>     [<ffffffff81097ded>] ret_from_fork+0x2d/0x70
>     [<ffffffff810034d1>] ret_from_fork_asm+0x11/0x20
> 
> Fixes: 64a5f972c93d ("fpga: add an initial KUnit suite for the FPGA Region")
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
>  drivers/fpga/tests/fpga-region-test.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/fpga/tests/fpga-region-test.c b/drivers/fpga/tests/fpga-region-test.c
> index 5ff688b394f9..7cd2667d52be 100644
> --- a/drivers/fpga/tests/fpga-region-test.c
> +++ b/drivers/fpga/tests/fpga-region-test.c
> @@ -95,6 +95,8 @@ static void fpga_region_test_class_find(struct kunit *test)
>  
>  	region = fpga_region_class_find(NULL, &ctx->region_pdev->dev, fake_region_match);
>  	KUNIT_EXPECT_PTR_EQ(test, region, ctx->region);
> +
> +	put_device(&region->dev);
>  }
>  
>  /*

