Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30F84305131
	for <lists+linux-fpga@lfdr.de>; Wed, 27 Jan 2021 05:46:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239539AbhA0Epm (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 26 Jan 2021 23:45:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36325 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388525AbhAZXX3 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 26 Jan 2021 18:23:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611703315;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FFsgQkQMHGcNuO7prFnbNLIMkPeBzSiQZrxd3POXfNg=;
        b=Kihxvzlqq1MbbO//yqVeXlI28T68f/yMLOkgQLQGqwxAr3EC59yoyeuZIJ9ki1NeL6VLbk
        Jt72GxB8vjukeVG2vsZFYMp/hZYK+W1K1tKwmbwafkvMCQgb0tR2ZI4vaM8cYi9a2x9fZj
        ZO4KoaXtLKXLUPD2GTa81ZV4ukjrg8Q=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-233-TkUWEMjKMuiI8N7s51Z--g-1; Tue, 26 Jan 2021 18:21:53 -0500
X-MC-Unique: TkUWEMjKMuiI8N7s51Z--g-1
Received: by mail-qt1-f197.google.com with SMTP id r18so6535479qta.19
        for <linux-fpga@vger.kernel.org>; Tue, 26 Jan 2021 15:21:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=FFsgQkQMHGcNuO7prFnbNLIMkPeBzSiQZrxd3POXfNg=;
        b=ASx/U/ID6ueJpdbV5YnQ2rtFPLh9uaNSncYdIW7w8YNjompwqdH1GD/uq464BErpme
         57OS04fL5WtN2ms4Pj3yAnaEvuU8Fw+3NGEKEIN2jmbLJy1QJCdIsAKM2hKvgxDDUnho
         OldpNzdPMzXuCCHAAF0Meli/woiJvdFLxVMXLRONxKUf2F16oArr8zfUUzTNDY0bmoiZ
         CJ+OUeSg3xYdi4Je9TW4sUsLoolxaOOc4PeT4u2p1DanvPeSrZDNc1k10BhqNif+wcHW
         ESjvynhUFlQp2U9hLDv0tLRA0IBAOQj2z8VagxrsXseHCZPJKbIP0oC3YwRCw9q/wsxf
         ohOA==
X-Gm-Message-State: AOAM532Pk7Bu9c/3JplwCHbCYEPPtvgy+S9qPvJiU74RG2jeJYqsZolE
        Y8DxKOkRk4ztmX4nL2Dqq66H27dXr2kUTES2OgPiUKmFk7R9RYTIcsm+yaw1VCsafeT74nlGId+
        HcsJAMeVpPGK+ZrRMpMPX8A==
X-Received: by 2002:a0c:c384:: with SMTP id o4mr8011139qvi.21.1611703313446;
        Tue, 26 Jan 2021 15:21:53 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyQwxGlyfMcY1NOcyyinpE4uDbuVGu0DgI2XyVdUzWX/kxECSPbaveR0jaQIYaDyMXFFNGuVg==
X-Received: by 2002:a0c:c384:: with SMTP id o4mr8011119qvi.21.1611703313228;
        Tue, 26 Jan 2021 15:21:53 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id c12sm154500qtq.76.2021.01.26.15.21.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Jan 2021 15:21:52 -0800 (PST)
Subject: Re: [PATCH v2 0/3] clk: clk-axiclgen: add support for ZynqMP
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        lars@metafoo.de, linux-fpga@vger.kernel.org, mdf@kernel.org
References: <20210126110826.24221-1-alexandru.ardelean@analog.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <eba46db2-b528-0f6f-7e23-f61fa3e265b2@redhat.com>
Date:   Tue, 26 Jan 2021 15:21:50 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210126110826.24221-1-alexandru.ardelean@analog.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


On 1/26/21 3:08 AM, Alexandru Ardelean wrote:
> Previous set:
>  https://lore.kernel.org/linux-clk/20201221144224.50814-1-alexandru.ardelean@analog.com/
>
> Changelog v1 -> v2:
> * split patch 'clk: axi-clkgen: add support for ZynqMP (UltraScale)'
>   into:
>    - clk: axi-clkgen: remove ARCH dependency in Kconfig
>    - clk: clk-axiclkgen: add ZynqMP PFD and VCO limits
> * essentially removed the 'adi,zynq-axi-clkgen-2.00.a' compat string
> * removed architecture dependency on build for driver; the driver should
>   be usable also on PCIe setups
>
> Alexandru Ardelean (3):
>   clk: axi-clkgen: remove ARCH dependency in Kconfig
>   clk: clk-axiclkgen: add ZynqMP PFD and VCO limits
>   dt-bindings: clock: adi,axi-clkgen: add compatible string for ZynqMP
>     support
>
>  .../devicetree/bindings/clock/adi,axi-clkgen.yaml     |  1 +
>  drivers/clk/Kconfig                                   |  1 -
>  drivers/clk/clk-axi-clkgen.c                          | 11 +++++++++++
>  3 files changed, 12 insertions(+), 1 deletion(-)

This whole set looks fine.

Reviewed-by: Tom Rix <trix@redhat.com>

