Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A50613340A1
	for <lists+linux-fpga@lfdr.de>; Wed, 10 Mar 2021 15:46:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232329AbhCJOqR (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 10 Mar 2021 09:46:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:46545 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232519AbhCJOp6 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 10 Mar 2021 09:45:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615387558;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Qe7vnreao5ThhJBhWOb2yAQo6akg/BiUCkUWjObNy9A=;
        b=UJio361ycv3FfHgO/mmDPV8NnheNq+6b7BM4cir6sh7v9lyIgnHZV5dXntjgjS58IgBwVx
        skhW+DM+vFerBkOgHL1x1qzXHM5KcDTkxN2ItkAfmsnEMRqu+vlKEdHtS3/tybYh8tsXTR
        S7dOLRZtgGrsvvX1ItBX4ajqwvTIN8A=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-352-QIsQPzPxNRacDeGfK0lDhA-1; Wed, 10 Mar 2021 09:45:55 -0500
X-MC-Unique: QIsQPzPxNRacDeGfK0lDhA-1
Received: by mail-qk1-f200.google.com with SMTP id b78so12880014qkg.13
        for <linux-fpga@vger.kernel.org>; Wed, 10 Mar 2021 06:45:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Qe7vnreao5ThhJBhWOb2yAQo6akg/BiUCkUWjObNy9A=;
        b=XF5DQQgw8JXA9pMzldE+3cqexHR1D3TfrKe9jpHNpGctAma03ngOhbXlJV2WdcYZkt
         cAkiWcxiomelCH1xWghCeWdSwQkdHANMAvzndbl0mJ9FYKLkWXJgeLMyqIZUwPbZkAc6
         qkpPgSYpkWmIgok1DzJErKO7e3TRSrgyAdutRDXP8Vge2TXOy8WnyezjcGRBCJrqc3BI
         sEKs/xcoTzTVotVfKyDWDR7E5NVy6l0Lum2E1gqA3QLRnAFzicsd/RlXfYkcpYfyG7G1
         oz3xdaxXw+KxkuvYwLn3O6btMXpnPrmIZXLeUSNxcOliwHCiPF+SwriRyETvZw7Ck6kO
         xIhQ==
X-Gm-Message-State: AOAM533A5PwIgair+nExEEDXz6DWazsXF1pvS0jsKTb00gZlCXaudlWH
        aGhQzqf84wv18MHJvigJXbyyLMckehC7FDX1LyEGegza9cxIEbm9L1HFtn6F5ZKLF5O3ogDa8rX
        y24Ud3MpNs+fQHuRHqC77qQ==
X-Received: by 2002:a0c:8ec7:: with SMTP id y7mr3256297qvb.9.1615387555273;
        Wed, 10 Mar 2021 06:45:55 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwlNoVM9BzWQNjpadCXVlfERPTQuROOGObYqvdAhHPCzlyHzhNVdnm6DSobOhCibwSlI7/4+g==
X-Received: by 2002:a0c:8ec7:: with SMTP id y7mr3256274qvb.9.1615387555052;
        Wed, 10 Mar 2021 06:45:55 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id d2sm12859520qkk.42.2021.03.10.06.45.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Mar 2021 06:45:54 -0800 (PST)
Subject: Re: [RFC v2 3/5] arm64: socfpga: rename ARCH_STRATIX10 to
 ARCH_SOCFPGA64
To:     Lee Jones <lee.jones@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Moritz Fischer <mdf@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-edac@vger.kernel.org, linux-fpga@vger.kernel.org,
        netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        arm@kernel.org, soc@kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>
References: <20210310083327.480837-1-krzysztof.kozlowski@canonical.com>
 <20210310083840.481615-1-krzysztof.kozlowski@canonical.com>
 <20210310094527.GA701493@dell>
From:   Tom Rix <trix@redhat.com>
Message-ID: <35c39c81-08e4-24c8-f683-2fa7a7ea71de@redhat.com>
Date:   Wed, 10 Mar 2021 06:45:50 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210310094527.GA701493@dell>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


On 3/10/21 1:45 AM, Lee Jones wrote:
> On Wed, 10 Mar 2021, Krzysztof Kozlowski wrote:
>
>> Prepare for merging Stratix 10, Agilex and N5X into one arm64
>> architecture by first renaming the ARCH_STRATIX10 into ARCH_SOCFPGA64.
>>
>> The existing ARCH_SOCFPGA (in ARMv7) Kconfig symbol cannot be used
>> because altera_edac driver builds differently between them (with
>> ifdefs).
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
>> ---
>>  arch/arm64/Kconfig.platforms                |  7 ++++---
>>  arch/arm64/boot/dts/altera/Makefile         |  2 +-
>>  arch/arm64/configs/defconfig                |  2 +-
>>  drivers/clk/Makefile                        |  2 +-
>>  drivers/clk/socfpga/Kconfig                 |  4 ++--
>>  drivers/edac/Kconfig                        |  2 +-
>>  drivers/edac/altera_edac.c                  | 10 +++++-----
>>  drivers/firmware/Kconfig                    |  2 +-
>>  drivers/fpga/Kconfig                        |  2 +-
>>  drivers/mfd/Kconfig                         |  2 +-
> If it's okay with everyone else, it'll be okay with me:
>
> Acked-by: Lee Jones <lee.jones@linaro.org>

I think the name is too broad, from the description in the config

+	bool "Intel's SoCFPGA ARMv8 Families"

A better name would be ARCH_INTEL_SOCFPGA64

So other vendors like Xilinx could do their own thing.

Tom

>
>>  drivers/net/ethernet/stmicro/stmmac/Kconfig |  4 ++--
>>  drivers/reset/Kconfig                       |  2 +-
>>  12 files changed, 21 insertions(+), 20 deletions(-)

