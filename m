Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 124A96C37FA
	for <lists+linux-fpga@lfdr.de>; Tue, 21 Mar 2023 18:14:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230508AbjCURMQ (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 21 Mar 2023 13:12:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231220AbjCURL4 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 21 Mar 2023 13:11:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA7C85371B
        for <linux-fpga@vger.kernel.org>; Tue, 21 Mar 2023 10:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679418622;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eV478PA/Hk/t+tkEqxFD+LaNbEr3bs77VNjalKwaSeE=;
        b=P6p2gXK3JPOaQiP029UD2GoIM68eKr88aJnQiOygrV7QCeB18huJmp7H1IrOvlB9mNZYzc
        BxZr8E7E4pIfO4bgW8Qu5GKTD2cybOnofg7t8wO0olfWbGUgQVBn/CCMLOmGDt7ChR7+ga
        aiGNg4CcaI+5I9hFbLjKTRJdJdOT3gs=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631-eLM2MYUuMeqJpElsXFVfWQ-1; Tue, 21 Mar 2023 13:10:18 -0400
X-MC-Unique: eLM2MYUuMeqJpElsXFVfWQ-1
Received: by mail-qt1-f199.google.com with SMTP id p19-20020ac87413000000b003d2753047cbso9182870qtq.19
        for <linux-fpga@vger.kernel.org>; Tue, 21 Mar 2023 10:10:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679418618;
        h=content-language:content-transfer-encoding:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eV478PA/Hk/t+tkEqxFD+LaNbEr3bs77VNjalKwaSeE=;
        b=aPj/XX8h3toMpYstQEZEK18F0Ub6mW+JXDNpMh1BhDKbsKlyhrmbdajX7FONqIchuk
         rEbNwZCOxGRvy5b6D8HMzPC9OhXBWosmUN5frJ9l7ZL9nkS0AI0eWwOGOi7E9jOJD9pH
         H0tYN4ttx7T2aIheyLD2h0zqCHghrRfPqETg3cEhOotl/2UK8l53bfp2TXQVKby1Mk8b
         5sYBFHV8n+nQ0bYUM1n0ZfaQfDYRaofzmPDNreCgL1loyU52BMJQf2tAIeEedptSVu4h
         Eo1av2Jz4i5u0f/W3qcvvsWgh3VKa+iQQ1GiFVlDWvLUy+iw/YVFq7I/tGHMaD0UbQS8
         oXdg==
X-Gm-Message-State: AO0yUKWxjsuwQFTcgruMuzxZN6T07Jsh3Y3BfhRorsEEmDkYn3KOK6c4
        NzhtvkcGpXQF/eCKx5RMri5hoW5HTo46U6YbTmSR5xaIwZHmlIB2tut9Z1zYRL64BdwOSh6D3RZ
        ByK9RBUiRZcwx3LbHjzw2Ti+IcLnv3jZsXDZrEYr+7FD6DdQW3Duuc1z3rNXFpUOs+QE/FBi1pm
        nb
X-Received: by 2002:a05:6214:1248:b0:5ab:af50:eb41 with SMTP id r8-20020a056214124800b005abaf50eb41mr1268703qvv.14.1679418618130;
        Tue, 21 Mar 2023 10:10:18 -0700 (PDT)
X-Google-Smtp-Source: AK7set97uIe6CMD1+C8TfEABm2y039+BlpvCFoYFo2lNCzufbwTL3awI2y6KlXes4DSNwbGg3evF/g==
X-Received: by 2002:a05:6214:1248:b0:5ab:af50:eb41 with SMTP id r8-20020a056214124800b005abaf50eb41mr1268633qvv.14.1679418617727;
        Tue, 21 Mar 2023 10:10:17 -0700 (PDT)
Received: from localhost.localdomain (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id j6-20020a05620a288600b00706bc44fda8sm9729513qkp.79.2023.03.21.10.10.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Mar 2023 10:10:17 -0700 (PDT)
Subject: Re: [PATCH] fpga: xilinx-pr-decoupler: Use readl wrapper instead of
 pure readl
To:     Michal Simek <michal.simek@amd.com>, linux-kernel@vger.kernel.org,
        monstr@monstr.eu, michal.simek@xilinx.com, git@xilinx.com
Cc:     Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Xu Yilun <yilun.xu@intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-fpga@vger.kernel.org
References: <0381e4e8061c2fee182a104768e84feff3a82d25.1679412800.git.michal.simek@amd.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <18e45db9-0b7d-abc3-5564-93968819f877@redhat.com>
Date:   Tue, 21 Mar 2023 10:10:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <0381e4e8061c2fee182a104768e84feff3a82d25.1679412800.git.michal.simek@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


On 3/21/23 8:33 AM, Michal Simek wrote:
> Driver has IO wrappers but xlnx_pr_decouple_read() is not used and readl is
> used instead which is just wrong.
> It is also generating sparse issue that xlnx_pr_decouple_read() is unused.
>
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
>
> Created based on discussion with Tom here
> https://lore.kernel.org/r/20230317230617.1673923-1-trix@redhat.com
> ---
>   drivers/fpga/xilinx-pr-decoupler.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/fpga/xilinx-pr-decoupler.c b/drivers/fpga/xilinx-pr-decoupler.c
> index 2d9c491f7be9..b76d85449b8f 100644
> --- a/drivers/fpga/xilinx-pr-decoupler.c
> +++ b/drivers/fpga/xilinx-pr-decoupler.c
> @@ -69,7 +69,7 @@ static int xlnx_pr_decoupler_enable_show(struct fpga_bridge *bridge)
>   	if (err)
>   		return err;
>   
> -	status = readl(priv->io_base);
> +	status = xlnx_pr_decouple_read(priv, CTRL_OFFSET);

Thanks for the change.

Reviewed-by: Tom Rix <trix@redhat.com>

>   
>   	clk_disable(priv->clk);
>   

