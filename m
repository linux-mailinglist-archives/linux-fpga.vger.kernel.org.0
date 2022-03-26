Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08E254E81F8
	for <lists+linux-fpga@lfdr.de>; Sat, 26 Mar 2022 17:56:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231758AbiCZQz7 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sat, 26 Mar 2022 12:55:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233801AbiCZQz6 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sat, 26 Mar 2022 12:55:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 707BDE096
        for <linux-fpga@vger.kernel.org>; Sat, 26 Mar 2022 09:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648313660;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=za0ay3SJgRTnl3/ewAAkXDmVNyKbkPpJW3j9ur8gjYg=;
        b=CsiXApo7yqnIX38ODweS6Msw3fQHHjIqdhsA+KNnIUbomiQNZKJA983kNM5oOkqZZOwvnX
        G8qBN/l8IQnRt7haaCsixdtTAQvzmw/37HJJN1+zQzY3vs+SDu/RyVm9F5oLSr33LbS8zw
        ps2uM119j+BRp+rnDzcCsy/vK90JOyo=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-607-D0VPtLYnOxyC0U9le2mOHw-1; Sat, 26 Mar 2022 12:54:09 -0400
X-MC-Unique: D0VPtLYnOxyC0U9le2mOHw-1
Received: by mail-qt1-f197.google.com with SMTP id u29-20020a05622a199d00b002e06ae2f56cso6574209qtc.12
        for <linux-fpga@vger.kernel.org>; Sat, 26 Mar 2022 09:54:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=za0ay3SJgRTnl3/ewAAkXDmVNyKbkPpJW3j9ur8gjYg=;
        b=2WMMT7VsCZfv/z/eoOdfVJrANQpKLNWvAsBKyBB//7cDAcyPgCzfNYOJjmzS6KtWu9
         wqlkxCB2QqH+rt1DetgnKkRgUkTAUqV+MO1FxOqddQC0aKTDoDnbqVrg5/2xF6VhDX7g
         VsZnibhV5dFwXqBO2Ul18kgalOaFlHJi9A3zLQuwPD5FgSCEn8nEZzLymIWELPxaZBgx
         l04ShuCL7TP0iSYtfqlY5+EporqIu6mjkXFshwWXTl3QCaTIcCjduo5SNt0JqxISB4SC
         6Id0CtnuIZ/34ehKpCYGtL3PhtdVPPbGMgJ8KpqdRn7Nf+iI1sUecWfIFTv+rP+csdEI
         SQuA==
X-Gm-Message-State: AOAM5329wmDQ+KxqSRxtggB4e2StjWwJ1PVVVLebAVuxEySYzGALgXyN
        n2AuqQVpKXROBmKxCrE9RhCGd45sgt0wzLjR7GsCWgJxtMvJ6GEtkSayoLBVkYmueUZAExq/FVL
        S92c8aXXEMdHRNjMT9YRk5w==
X-Received: by 2002:a05:620a:2453:b0:67d:9539:495c with SMTP id h19-20020a05620a245300b0067d9539495cmr11101500qkn.30.1648313649225;
        Sat, 26 Mar 2022 09:54:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxiPtOqE8LTGIHc8M7DmjMjq3TXcyBVbM2eRHpJShxnnQ1BzEa9HJ1tbpil4Kaf4dCjWy+54A==
X-Received: by 2002:a05:620a:2453:b0:67d:9539:495c with SMTP id h19-20020a05620a245300b0067d9539495cmr11101485qkn.30.1648313648964;
        Sat, 26 Mar 2022 09:54:08 -0700 (PDT)
Received: from localhost.localdomain (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id x19-20020a05620a14b300b0067e09a47e39sm4931700qkj.34.2022.03.26.09.54.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Mar 2022 09:54:08 -0700 (PDT)
Subject: Re: [PATCH v2 1/5] fpga: zynq: Fix incorrect variable type
To:     Nava kishore Manne <nava.manne@xilinx.com>, mdf@kernel.org,
        hao.wu@intel.com, yilun.xu@intel.com, michal.simek@xilinx.com,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, git@xilinx.com
References: <20220322082202.2007321-1-nava.manne@xilinx.com>
 <20220322082202.2007321-2-nava.manne@xilinx.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <aa99b73f-0169-0d16-0bce-ac3f3dfffa68@redhat.com>
Date:   Sat, 26 Mar 2022 09:54:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20220322082202.2007321-2-nava.manne@xilinx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


On 3/22/22 1:21 AM, Nava kishore Manne wrote:
> zynq_fpga_has_sync () API is expecting "u8 *" but the
> formal parameter that was passed is of type "const char *".
> To fix this issue cast the const char pointer to u8 pointer.
>
> Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
> ---
> Changes for v2:
> 		-None.
>
>   drivers/fpga/zynq-fpga.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/fpga/zynq-fpga.c b/drivers/fpga/zynq-fpga.c
> index 426aa34c6a0d..12f644e79e91 100644
> --- a/drivers/fpga/zynq-fpga.c
> +++ b/drivers/fpga/zynq-fpga.c
> @@ -275,7 +275,7 @@ static int zynq_fpga_ops_write_init(struct fpga_manager *mgr,
>   
>   	/* don't globally reset PL if we're doing partial reconfig */
>   	if (!(info->flags & FPGA_MGR_PARTIAL_RECONFIG)) {
> -		if (!zynq_fpga_has_sync(buf, count)) {
> +		if (!zynq_fpga_has_sync((u8 *)buf, count)) {

Instead of casting, change the signature of zynq_fpga_has_sync to use 
const char * over const *u8.

Also please review the implementation of zynq_fpga_has_sync.

The comments says 'It must start with .. ' but the loop looks over the 
whole buffer

Tom

>   			dev_err(&mgr->dev,
>   				"Invalid bitstream, could not find a sync word. Bitstream must be a byte swapped .bin file\n");
>   			err = -EINVAL;

