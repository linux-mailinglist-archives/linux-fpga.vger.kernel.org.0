Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3A6951FD49
	for <lists+linux-fpga@lfdr.de>; Mon,  9 May 2022 14:52:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234694AbiEIMsN (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 9 May 2022 08:48:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234682AbiEIMsF (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 9 May 2022 08:48:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8094E19875A
        for <linux-fpga@vger.kernel.org>; Mon,  9 May 2022 05:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652100243;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=c7/SXhV1I0JuB9mdx/LYi/9cLxe2PenDAh/hDIw0UcE=;
        b=HCt3P38ShBtopHbF4Uc5FIsH6cy7w/Y4yb5HV9RfsaN8A/+UdrdFWH7TFcv622XGRAJU+r
        H+JPPLuE57Y5O8VqCIJzXqpfTvjopZnybn1cRacV82VRnOmbGP1VbfphC3JR6SNS3Eozof
        4yHg5CZ79NqHlb/GU9CoISM5SO35DNc=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-380-T88FIFHBNFy9iNLNxbsuXA-1; Mon, 09 May 2022 08:44:02 -0400
X-MC-Unique: T88FIFHBNFy9iNLNxbsuXA-1
Received: by mail-qv1-f71.google.com with SMTP id k13-20020a05621414ed00b0045ae9344714so6740918qvw.8
        for <linux-fpga@vger.kernel.org>; Mon, 09 May 2022 05:44:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=c7/SXhV1I0JuB9mdx/LYi/9cLxe2PenDAh/hDIw0UcE=;
        b=HK2TY/jjFLl3xdTgZTYhz/RZ0RoB3OU3fbmjIdzKBeUujYWt0wGKorg8Nru2zZK3ma
         38K3hLxJxRVy2+iz+HdHszmF92EvmMktaIlu6VFjqieTZ0CbdMTRdmT3mDK79vDvC0CL
         teRVrPWG9BBhJNidElPyQbp4WiPXzw1QO/7ZhqCeJ074WzcOsOTzB/qSL7wY90nkKp+l
         kO0Ia5wsN6rO2S3CwZtJIppM/NNxOR9ws76zb0o8JcuLhn3eRHUW5aDSY3YmmGsRQ+FG
         PmlW7pqlg7a2iAa7lMMn+F37lmTDYCl3K6VAlGveh/8TfGDmWmPy6vhQCYwVopca2Q+R
         aJKw==
X-Gm-Message-State: AOAM530fCyQTUOrg3dxE4KtSloZmNSV/D9uqAa2KfPfXHCwOeV/YMhnR
        3D6Btp+DSTgeop60tO59YuNQLv4IfcC0G0Y0yknswMJsm6X6tkJHodWKK4c1UgbMQ+AZGIYmTrU
        4dM7YaCZ0y/fp90D9jA07PQ==
X-Received: by 2002:a37:a497:0:b0:6a0:a704:b49b with SMTP id n145-20020a37a497000000b006a0a704b49bmr1629083qke.453.1652100242064;
        Mon, 09 May 2022 05:44:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzguJ8plAlDd0cXSR1ev+D+vRtToG4GOdfdBRvIUj7ZHaSs7j/ZDhxa+NExb/eDsIJ5zVtXYg==
X-Received: by 2002:a37:a497:0:b0:6a0:a704:b49b with SMTP id n145-20020a37a497000000b006a0a704b49bmr1629064qke.453.1652100241828;
        Mon, 09 May 2022 05:44:01 -0700 (PDT)
Received: from localhost.localdomain (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id a26-20020ac84d9a000000b002f39b99f676sm7519445qtw.16.2022.05.09.05.43.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 May 2022 05:44:01 -0700 (PDT)
Subject: Re: [PATCH] fpga: zynq: fix zynq_fpga_has_sync()
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Moritz Fischer <mdf@kernel.org>,
        Nava kishore Manne <nava.manne@xilinx.com>,
        Xu Yilun <yilun.xu@intel.com>, Wu Hao <hao.wu@intel.com>
Cc:     Michal Simek <michal.simek@xilinx.com>, linux-fpga@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <YnkE8AbimDa7sfN8@kili>
From:   Tom Rix <trix@redhat.com>
Message-ID: <b1448881-4a68-0bc4-b828-0b9c79ffdf11@redhat.com>
Date:   Mon, 9 May 2022 05:43:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <YnkE8AbimDa7sfN8@kili>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


On 5/9/22 5:11 AM, Dan Carpenter wrote:
> The type needs to be u8.  The type was accidentally changed to char as
> a cleanup.  Unfortunately, that meant that the zynq_fpga_has_sync()
> function never returns true.  This bug was detected by Smatch and Clang:
>
> drivers/fpga/zynq-fpga.c:245 zynq_fpga_has_sync() warn: impossible condition '(buf[2] == 153) => ((-128)-127 == 153)'
> drivers/fpga/zynq-fpga.c:246 zynq_fpga_has_sync() warn: impossible condition '(buf[3] == 170) => ((-128)-127 == 170)'
>
> drivers/fpga/zynq-fpga.c:246:14: warning: result of comparison of
> constant 170 with expression of type 'const char' is always false
> [-Wtautological-constant-out-of-range-compare]
>                         buf[3] == 0xaa)
>                         ~~~~~~ ^  ~~~~
> drivers/fpga/zynq-fpga.c:245:50: warning: result of comparison of
> constant 153 with expression of type 'const char' is always false
> [-Wtautological-constant-out-of-range-compare]
>                     if (buf[0] == 0x66 && buf[1] == 0x55 && buf[2] == 0x99 &&
>                                                             ~~~~~~ ^  ~~~~
>
> Fixes: ada14a023a64 ("fpga: zynq: Fix incorrect variable type")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
> The ada14a023a64 ("fpga: zynq: Fix incorrect variable type") patch went
> through six of revisions.  The kbuild bug found this bug early on
> but the author ingored kbuild-bot and kept resending the buggy patch
> anyway.
>
> After the patch was merged then I sent a separate bug report and Xu
> Yilun asked about why only the author was on the CC list for the first
> bug reports.  A valid question, definitely.  I will poke the kbuild
> devs about this.
>
> Hm...  Actually looking through the list there have been a bunch of bug
> reports about this because both Smatch and Clang complain so kbuild
> sends duplicate warnings for this type of bug.  And then kbuild
> sends another to say "This issue is still remaining" warning.  And then
> Xu Yilun sent an email "Kbuild-bot is still complaining.  Please don't
> forget to fix this."  So that's at least four public emails about this
> and one or two private emails directly from kbuild-bot to the author.
>
> The kbuild-bot wanted to send *another* warning today, but I decided to
> send a fix instead.
>
> LOL.
>
>   drivers/fpga/zynq-fpga.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/fpga/zynq-fpga.c b/drivers/fpga/zynq-fpga.c
> index 6beaba9dfe97..426aa34c6a0d 100644
> --- a/drivers/fpga/zynq-fpga.c
> +++ b/drivers/fpga/zynq-fpga.c
> @@ -239,7 +239,7 @@ static irqreturn_t zynq_fpga_isr(int irq, void *data)
>    * the correct byte order, and be dword aligned. The input is a Xilinx .bin
>    * file with every 32 bit quantity swapped.
>    */
> -static bool zynq_fpga_has_sync(const char *buf, size_t count)
> +static bool zynq_fpga_has_sync(const u8 *buf, size_t count)

This is called from zynq_fpga_ops_write_init, a fpga_manager_ops 
function that

uses 'const char *' as a type for its write() buf's.

I think const u8 * would be a better type for all of the fpga_manager 
instances.

If folks agree, I'll make the change.

Tom

>   {
>   	for (; count >= 4; buf += 4, count -= 4)
>   		if (buf[0] == 0x66 && buf[1] == 0x55 && buf[2] == 0x99 &&

