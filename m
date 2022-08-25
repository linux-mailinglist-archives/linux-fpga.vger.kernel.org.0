Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9825E5A0F69
	for <lists+linux-fpga@lfdr.de>; Thu, 25 Aug 2022 13:38:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233215AbiHYLg6 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 25 Aug 2022 07:36:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236668AbiHYLgk (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 25 Aug 2022 07:36:40 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4623658DE3
        for <linux-fpga@vger.kernel.org>; Thu, 25 Aug 2022 04:36:07 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id l8so10309324lfc.12
        for <linux-fpga@vger.kernel.org>; Thu, 25 Aug 2022 04:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=oZwcSMvVsfx9doV0q7DqmNxQNSEHGaC/BV7ytitFLGU=;
        b=BdGYPXBSS3V3bAhz4zNmfM4vKCiupnBooioav9iBsx4+IpX8WeZo2k59N2aLpbd7ia
         iw2iZyQQh5vrRFLpAYGkUp1RkoGOXXObTXQZxVXz2o92bV30eN5chDzO0xgnpiy9FUkb
         jQNIwGCVfoon+wpMvaBzlKyWGG0LVfqoM7P2TVheMhlcSA+gxCD/6fAiWv/IfIh0/vXJ
         mChmaaPcD0YFLiGLeTBuPi1SjnQHqmVdIxial2oYUQJaSEUa30uZFO3gELAyqTOvm1B0
         EQ1lyBer/tgmDHiB+92AAyJUjGhBUrKyO8q6MhnCrTO4etn28PJtVA+UIuviXNiR49a5
         TEkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=oZwcSMvVsfx9doV0q7DqmNxQNSEHGaC/BV7ytitFLGU=;
        b=hHPbBMcmS8FxS32rf2EhyY7htkygPrcg78jUVsvn7uOj2z5530/OgG2vYHmr2/QsA7
         0pEuK4ULMeJS6UI5mZO4hWgp5hRyGY+9TqsRTdFQrS5E9NFkD/q5b7JKU3Xi9L4YQ3Td
         OSNDKmwfs9px+05XYr6BT/Af+bNICgO2nbEfApK7sMdBf/7/4Ms3KQQ6AyHKQbKKbuMD
         pAjBbfkpedNkkRuC05BeQvTjvwbJ2ysDD5MDyMbnckccJ6i5hsPX+/fhYJWiqyuI6hd+
         kIVQMbB+bS+ouIF6xCVdOne8i71dLioE8QCbD8UWLfnR3CJewUTLIrR+yzdBDe9typjr
         ltuA==
X-Gm-Message-State: ACgBeo27Mk5TmM/H+RCOn2uX+Nh7bR8BggjRB2biXx1KgPHPbGVJrjPk
        z//ZBkaCKGM0mhkFaA4Mp5KcHA==
X-Google-Smtp-Source: AA6agR6HWa0LiqyvcF2tneJITEdLk6Y94XPwsN0P1Z3BTUsFLertwvgdBvc6gEah4VXzUNeMbrKIZQ==
X-Received: by 2002:a05:6512:3e03:b0:492:e10a:eb73 with SMTP id i3-20020a0565123e0300b00492e10aeb73mr948559lfv.609.1661427365410;
        Thu, 25 Aug 2022 04:36:05 -0700 (PDT)
Received: from [192.168.0.71] (82.131.98.15.cable.starman.ee. [82.131.98.15])
        by smtp.gmail.com with ESMTPSA id s10-20020a056512202a00b00492ef1ee7b0sm438565lfs.290.2022.08.25.04.36.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Aug 2022 04:36:04 -0700 (PDT)
Message-ID: <7772baf3-1e76-9f0a-2e77-cdf852137ae6@linaro.org>
Date:   Thu, 25 Aug 2022 14:36:03 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v8 2/2] dt-bindings: fpga: document Lattice sysCONFIG FPGA
 manager
Content-Language: en-US
To:     Ivan Bornyakov <i.bornyakov@metrotek.ru>, mdf@kernel.org,
        hao.wu@intel.com, yilun.xu@intel.com, trix@redhat.com,
        dg@emlix.com, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     linux-fpga@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, system@metrotek.ru
References: <20220825112433.14583-1-i.bornyakov@metrotek.ru>
 <20220825112433.14583-3-i.bornyakov@metrotek.ru>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220825112433.14583-3-i.bornyakov@metrotek.ru>
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

On 25/08/2022 14:24, Ivan Bornyakov wrote:
> Add Device Tree Binding doc for configuring Lattice ECP5 and MachXO2
> FPGAs over Slave SPI sysCONFIG interface.
> 
> Signed-off-by: Ivan Bornyakov <i.bornyakov@metrotek.ru>

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
