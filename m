Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A57E574D1B
	for <lists+linux-fpga@lfdr.de>; Thu, 14 Jul 2022 14:09:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239223AbiGNMHo (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 14 Jul 2022 08:07:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239158AbiGNMGr (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 14 Jul 2022 08:06:47 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8503C5D0C0
        for <linux-fpga@vger.kernel.org>; Thu, 14 Jul 2022 05:06:46 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id u13so2449628lfn.5
        for <linux-fpga@vger.kernel.org>; Thu, 14 Jul 2022 05:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=JP/tjZFPBXiPkDSIwi7EAQJKbNtxPejuw/369uy5bpE=;
        b=jP4WCMy3/arJ4RhHvkcrhWISPYiHpg0OvEjdj9bjHpSaQ4KdQJMvMOjjWbrZBYlIik
         LzvjFsoOh5iHvPLBBDJooEVW7PFLCulA+TLiuH3r3CBzlZZvsobyEHhn0qi+XCfhWwLm
         LXoZcjZq0IUlkZoN37mqJekJ1uMvj4WGbGlJ9CstWqf2M3SIo/PE/uqoT+wEW1PojO40
         0EhTOEYw2Pg6C7NxpMuzEgYhvF5aCjntoNgqHhGn28DqL5dJkAzEjMOkE7t2tfhHEBcx
         fiomK6QETXnkHC4mfOYt8zB8WxgTvPX7/SboaIqhLy2cyqErWHYq8s/UCSHiCvS3mYQ0
         wWUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=JP/tjZFPBXiPkDSIwi7EAQJKbNtxPejuw/369uy5bpE=;
        b=LZX6I9idYZ9Dv3GNSMWSvtTZ6SF+acX4oBkwwlDCVbBz1PdjAL25glGgl56RlF3qqI
         MqJcwBjbiH1TXje79+VO0YgoCGAkQ1RMneFZI5gSDTXc/Jt90KgnIZtSXAr1twC4Y+Es
         FmGWyXJDS602IBfpOFmuP9P90FhioAfranYLgTaH4CF71PsX4oil8+yzy30yf71MtKLP
         D/bQ6t2SQhIGaQU0/UW6s7naAvhFIIvXnkeQUVVRAKnlUMb4M/p+Sj3arpxbcfL0fHiz
         jskcKKPPRXoBTIIGivgWwcVA86n+KjznWU2p850D5ppNxDphx16QhrZAmHAZqSWGNoHR
         ST2w==
X-Gm-Message-State: AJIora/pFKkz3ikvurI2tsSOfCOkG0MKwHMTmk0CWDN+saoB7e57xcnN
        VIuI0kNR4nt1LIccJVmrRfhbAg==
X-Google-Smtp-Source: AGRyM1s1AwL/+8iWanx4h7Go7zVLShOosA3NySOVsXYXmBYOFy6q4waOvoW9Qs0gIoSLh8jw0T4lTw==
X-Received: by 2002:a05:6512:118b:b0:46b:a9ae:3a3b with SMTP id g11-20020a056512118b00b0046ba9ae3a3bmr4639039lfr.188.1657800404841;
        Thu, 14 Jul 2022 05:06:44 -0700 (PDT)
Received: from [10.0.0.8] (fwa5da9-171.bb.online.no. [88.93.169.171])
        by smtp.gmail.com with ESMTPSA id b16-20020a056512071000b004886508ca5csm327879lfs.68.2022.07.14.05.06.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Jul 2022 05:06:44 -0700 (PDT)
Message-ID: <54b0e279-5eac-b304-05d0-9bc64a94cbd3@linaro.org>
Date:   Thu, 14 Jul 2022 14:06:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2] memory: dfl-emif: Update the dfl emif driver support
 revision 1
Content-Language: en-US
To:     Tianfei Zhang <tianfei.zhang@intel.com>, ssantosh@kernel.org
Cc:     trix@redhat.com, yilun.xu@intel.com, russell.h.weight@intel.com,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        matthew.gerlach@linux.intel.com,
        Debarati Biswas <debaratix.biswas@intel.com>
References: <20220713130355.196115-1-tianfei.zhang@intel.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220713130355.196115-1-tianfei.zhang@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On 13/07/2022 15:03, Tianfei Zhang wrote:
> From: Debarati Biswas <debaratix.biswas@intel.com>
> 
> The next generation (revision 1) of the DFL EMIF feature device requires
> support for more than 4 memory banks. It does not support the selective
> clearing of memory banks. A capability register replaces the previous
> control register, and contains a bitmask to indicate the presence of each
> memory bank. This bitmask aligns with the previous control register
> bitmask that served the same purpose. The control and capability
> registers are treated like a C Union structure in order to support both
> the new and old revisions of the EMIF device.
> 
> Signed-off-by: Debarati Biswas <debaratix.biswas@intel.com>
> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> Signed-off-by: Tianfei Zhang <tianfei.zhang@intel.com>
> ---

Thanks for the patch and for the review.

It is too late in the cycle for me to pick it up. I will take it after
the merge window.


Best regards,
Krzysztof
