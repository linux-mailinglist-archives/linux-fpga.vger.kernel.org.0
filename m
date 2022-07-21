Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B8A557C576
	for <lists+linux-fpga@lfdr.de>; Thu, 21 Jul 2022 09:40:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232145AbiGUHib (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 21 Jul 2022 03:38:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231381AbiGUHib (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 21 Jul 2022 03:38:31 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 930917C1B9
        for <linux-fpga@vger.kernel.org>; Thu, 21 Jul 2022 00:38:29 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id a9so1426811lfk.11
        for <linux-fpga@vger.kernel.org>; Thu, 21 Jul 2022 00:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=d6jGJRgP28s+BMa24FY7e5/52tB4SvyCHdjl8vUxj90=;
        b=d/WiiK64fg2mfbK2F5bWOrnvfixjgUvgcH7SYwB1KiB6ashLXWbyG97kVwrzVN5QP0
         Q95g1zUTmYwzqrxN0MtNFBE1wpD+fJEoJ0hiLjWjnwPpZh+A2JDYl66ACbaB0h6L+LEy
         7gXSu0m3lVSIYXEP6NcSJ12/28YEi2YN2RgnwkVYhM6Ts/CJ+mhOvY74baxv2Z8xNA11
         KyjyUyzY9/6zWuVgFihQ8di9jELhsQM35kX2p+7BzKHblP/tTaPFvJRabpIHrPKXERF5
         XWzgm15I28DE21vmJxzTfiAlPOAYx4vh41y1YQdOa6JNp3kfH6Etfi+m7dGPA0NhdzU6
         x5sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=d6jGJRgP28s+BMa24FY7e5/52tB4SvyCHdjl8vUxj90=;
        b=nxR1ygTvyNgbKVA/AQ2wOR1UWwoDdXVVYwO9IIp3vg1ogrp3SUxkf+9dmCWhou8xPE
         YtOSKxE2Gp3PzbGhHK3RJxw0FL8TjpSJlrNf8qlMJkT67KWAO3aIl37X8vxk+V4s07Rr
         wZ2W2b9Hrb9NqYuJSCO8f40S1PCXJPXQAuczx9QfMDaa6D0jKTrkPRg4FnRsZNUoHwTy
         Sb6c5iiID4DPQboJfQyh0LX12XEWlMqHCV80h4G01H0WpHt7RK0Uhgkuo6glBX3sZgz8
         PIfZuZjenft0ZlJgSCds82iz8+5scAcORDyn47cpR2/bEIwMnakyhdWEWITc1gDYHJrt
         9l7Q==
X-Gm-Message-State: AJIora9ey+zc7FPKe+1FAIw8ps8XVAnwiBeUucwMQjMT9esHajAdMD+k
        sqZJyIy6NGZufrcjuSjbdhVEbg==
X-Google-Smtp-Source: AGRyM1tT45IGEfPxkG0QUWXabfRtQxNvaqKdyD3fesSA/0jHtx4i/CdHDTIVYSqp6uxsMq2efr4Jkw==
X-Received: by 2002:a05:6512:1090:b0:489:d620:44b7 with SMTP id j16-20020a056512109000b00489d62044b7mr24111802lfg.554.1658389107945;
        Thu, 21 Jul 2022 00:38:27 -0700 (PDT)
Received: from [192.168.115.193] (89-162-31-138.fiber.signal.no. [89.162.31.138])
        by smtp.gmail.com with ESMTPSA id k10-20020a05651c10aa00b0025d6895ffa9sm307192ljn.98.2022.07.21.00.38.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Jul 2022 00:38:27 -0700 (PDT)
Message-ID: <e69c6a65-2c8d-6b35-54f9-e16008cbfc50@linaro.org>
Date:   Thu, 21 Jul 2022 09:38:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 2/3] fpga: region: Add fpga-region 'power-domains'
 property
Content-Language: en-US
To:     Nava kishore Manne <nava.manne@xilinx.com>, mdf@kernel.org,
        hao.wu@intel.com, yilun.xu@intel.com, trix@redhat.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        michal.simek@xilinx.com, linux-fpga@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, git@xilinx.com
Cc:     Rob Herring <robh@kernel.org>
References: <20220523134517.4056873-1-nava.manne@xilinx.com>
 <20220523134517.4056873-3-nava.manne@xilinx.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220523134517.4056873-3-nava.manne@xilinx.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On 23/05/2022 15:45, Nava kishore Manne wrote:
> Add fpga-region 'power-domains' property to allow to handle
> the FPGA/PL power domains.
> 
> Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
> Acked-by: Rob Herring <robh@kernel.org>
> ---
> Changes for v2:
>               - Updated power-domains description.
> 
>  .../devicetree/bindings/fpga/fpga-region.txt       | 14 ++++++++++++++

Please use subject matching the file, so you have to include dt-bindings
as one of the prefixes.


Best regards,
Krzysztof
