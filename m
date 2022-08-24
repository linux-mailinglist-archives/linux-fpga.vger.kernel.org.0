Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 811F959FAC5
	for <lists+linux-fpga@lfdr.de>; Wed, 24 Aug 2022 15:02:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237723AbiHXNAJ (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 24 Aug 2022 09:00:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237818AbiHXNAF (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 24 Aug 2022 09:00:05 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4E8E80EBB
        for <linux-fpga@vger.kernel.org>; Wed, 24 Aug 2022 06:00:02 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id q18so15348076ljg.12
        for <linux-fpga@vger.kernel.org>; Wed, 24 Aug 2022 06:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=hAbVBhjOPTfMrKNm7vMip2b0SbCUDi5IKdgpzFAMfGw=;
        b=g+pyoW3Vs/G7PyIadnuuaBScMoOxN90Ic8JYrAZJJLNG4HjPINWySlrruJlTnZc+XL
         7noZtNUYOVHllPOojKVVU91lNydxIiYaUSO8pL5o0VWFiU4SNR+TJ2t9OB3CP+fwQ+De
         LZeMKCbaBQEUsco/OAopeDUd+4IMfovVZJ8NsZ+W2GYgNxc8HefDJvUAObV3nU1TzHHO
         QB+gTCr8dp/se+JYdXV3cVuhs+hEcl5zgrxmTrzIc+9msllpVqGClAQEJeWcpLHe/s6a
         uU/0LYeZxfm4Uqj4jvTpfcxeP7timtxztREKUJ+dAAZ0D/NfvP6eQuCPUl6juC3h3huz
         t2Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=hAbVBhjOPTfMrKNm7vMip2b0SbCUDi5IKdgpzFAMfGw=;
        b=dPgK+RQogGijbdZ+NTGYbq74SELwNgVrOMyp49dhwimr1quO05bPKr26qHa9p18zdg
         qi1qB3LEZYa8OG49jp70qXrbyCRWqslE1XbD5VDeBcHvekuPasx/D6jeHFu1cwfoWT44
         2Usk7mUackPdKCvvfNIHz08I5XfmeZFlp8LY2F0y3ZoZceGTmr3qh7O1pb4cLKJrp5WO
         90pmUoieGg8o+7u2/bWpugUOoxKsA2a7tTnPLFNCxNWXPwn34tbbCWhimL68/ocybUte
         X4M8SawyUdNDehXwnb6YftnKQ8tlKG0+kIcwKHUtLqUszXj+32GMb/1zMxG1apq0orNm
         JUAA==
X-Gm-Message-State: ACgBeo0xpx3350MoBd+j26LbBUGyJ4TQr2ywAEraGY5iQd3gAKl+BeRm
        wDqxnZ0BcNXS3SvGAUWN6FQDlQ==
X-Google-Smtp-Source: AA6agR6GPFbry8u5NJDphlPxo027AAqzvOm1GocHUvEiaoKUex+2hmRnYlF+nUCNuD9bBC60u4eQfA==
X-Received: by 2002:a2e:a7ca:0:b0:261:d42c:628b with SMTP id x10-20020a2ea7ca000000b00261d42c628bmr2843065ljp.480.1661346001095;
        Wed, 24 Aug 2022 06:00:01 -0700 (PDT)
Received: from [10.243.4.185] ([194.157.23.230])
        by smtp.gmail.com with ESMTPSA id g8-20020a2eb5c8000000b00261c6c80b38sm2060178ljn.75.2022.08.24.05.59.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Aug 2022 06:00:00 -0700 (PDT)
Message-ID: <25b178d0-9602-99a0-46c0-0f9687d8d05a@linaro.org>
Date:   Wed, 24 Aug 2022 15:59:58 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 4/4] fpga: zynqmp: Add afi config driver
Content-Language: en-US
To:     Nava kishore Manne <nava.kishore.manne@amd.com>, git@amd.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        michal.simek@xilinx.com, mdf@kernel.org, hao.wu@intel.com,
        yilun.xu@intel.com, trix@redhat.com, p.zabel@pengutronix.de,
        gregkh@linuxfoundation.org, ronak.jain@xilinx.com,
        rajan.vaja@xilinx.com, abhyuday.godhasara@xilinx.com,
        piyush.mehta@xilinx.com, lakshmi.sai.krishna.potthuri@xilinx.com,
        harsha.harsha@xilinx.com, linus.walleij@linaro.org,
        nava.manne@xilinx.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-fpga@vger.kernel.org
References: <20220824035542.706433-1-nava.kishore.manne@amd.com>
 <20220824035542.706433-5-nava.kishore.manne@amd.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220824035542.706433-5-nava.kishore.manne@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On 24/08/2022 06:55, Nava kishore Manne wrote:
> Add zynqmp AXI FIFO interface(AFI) config driver. This is useful for the
> configuration of the PS-PL interface on Zynq US+ MPSoC platform.
> 
> Signed-off-by: Nava kishore Manne <nava.kishore.manne@amd.com>
> ---

(...)

> +
> +static struct platform_driver zynqmp_afi_driver = {
> +	.probe = zynqmp_afi_probe,
> +	.remove = zynqmp_afi_remove,
> +	.driver = {
> +		.name = "zynqmp_afi",
> +		.of_match_table = of_match_ptr(zynqmp_afi_of_match),

It should generate warnings... test compile your driver.

Drop of_match_ptr() or use __maybe_unused

Best regards,
Krzysztof
