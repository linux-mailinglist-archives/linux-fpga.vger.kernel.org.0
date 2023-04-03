Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00B946D5170
	for <lists+linux-fpga@lfdr.de>; Mon,  3 Apr 2023 21:37:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231571AbjDCTfZ (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 3 Apr 2023 15:35:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231538AbjDCTfZ (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 3 Apr 2023 15:35:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A06FA3;
        Mon,  3 Apr 2023 12:35:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E9732625A0;
        Mon,  3 Apr 2023 19:35:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A1F2C433D2;
        Mon,  3 Apr 2023 19:35:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680550523;
        bh=jvtnWZFI2fGJeH2PxHp6LZJsWoWybXxjuO7vI5xdc+k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y6p7mCvxr0BUh3aKtOMbCLM5/EIMGrzSJ9otvW1VaUDMJMnk+iJjhwZovzRPSKHGh
         enymh2tMk49s2QKiOozwHvchGRtbYQRL5Ol/YfMF9gBH3tf8iU7w/Q1CLoygJ/bTvB
         pQbNPxG0FRPjVBMDEsi+Nz9y8JWClfstHkWoHyRXWX6WH0PPIrD7MZr4C8+56Z8Uh2
         /PSARdk4QAzH33kABAqlbI1+dr9kSBiUKatImd/nON1sEIWAP53B1n8LL2coMuD2AW
         G7EyDPUI4pvKeK+h9F2Z18SyAKN3F1Mcgl1HbSlKPnpJQ8l8FD0dgBJBQTBbpneqr8
         w2jCLwTX9pGSw==
From:   Conor Dooley <conor@kernel.org>
To:     linux-fpga@vger.kernel.org,
        Conor Dooley <conor.dooley@microchip.com>
Cc:     conor@kernel.org, Daire McNamara <daire.mcnamara@microchip.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH v2 0/7] PolarFire SoC Auto Update Support
Date:   Mon,  3 Apr 2023 20:34:59 +0100
Message-Id: <20230403-audacity-champion-9aa7a47939f0@spud>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230331071823.956087-1-conor.dooley@microchip.com>
References: <20230331071823.956087-1-conor.dooley@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=818; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=YlEC6sgE+Yocm04DZPoSm8ShZaYEwmR3DSX9EC6jsCo=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDCnaWomZhzYo6ft1XXtpV/K3bxuLt0rLQtVrvUefWJxPF 5i+WM6yo5SFQYyDQVZMkSXxdl+L1Po/Ljuce97CzGFlAhnCwMUpABNZGcbwV7Cda2eLu27inZjv HTJbdki4z2NY1VTb/WTRSr1nNfvnOzMyrGc6fDhNrmezc+TWuuqrzzL28D51PvBx0jnRf9eXfCn 4zwIA
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Conor Dooley <conor.dooley@microchip.com>

On Fri, 31 Mar 2023 08:18:16 +0100, Conor Dooley wrote:
> Hey all,
> 
> This patchset adds support for the "Auto Update" feature on PolarFire
> SoC that allows for writing an FPGA bistream to the SPI flash connected
> to the system controller.
> On powercycle (or reboot depending on how the firmware implements the
> openSBI SRST extension) "Auto Update" will take place, and program the
> FPGA with the contents of the SPI flash - provided that that image is
> valid and an actual upgrade from that already programmed!
> 
> [...]

Gonna take this one patch, since it's got ~nothing to do with the rest
of the series really, so:

Applied to riscv-soc-for-next, thanks!

[1/7] soc: microchip: mpfs: add a prefix to rx_callback()
      https://git.kernel.org/conor/c/4dd472bdafcb

Thanks,
Conor.
