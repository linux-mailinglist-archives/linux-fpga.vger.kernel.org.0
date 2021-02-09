Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5095314650
	for <lists+linux-fpga@lfdr.de>; Tue,  9 Feb 2021 03:30:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230365AbhBICa0 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 8 Feb 2021 21:30:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:60950 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229544AbhBICaX (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 8 Feb 2021 21:30:23 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 22E9C64E99;
        Tue,  9 Feb 2021 02:29:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612837782;
        bh=4k3ujqQqNC2iTe5z4ps8edehSitDvZ8vKyWUoWHqPx4=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=RGW14k3Of7ThljMirTBBPrFMhZMoQXQCr5MQqGZVD1a7GdPgnHzH8E3iNIKGJQZNp
         h7ixVNxEAwgxG+H/Vw8JPT/Vazl0TA4bxETrd0YVkezAV/+8dSHroA4WKrHW/hd7sF
         mnNiE4XbrvOapvbMAcRxBR9tR2nLsT385wWOqfxu3aWr6wXGYoEE3OcpenvCdh4ijj
         XjeaduOmEUh2ZUg8AJGTwL6QPpFwPrKp9MHPL6GDpjY+niDvTytDhEZYb0c61PcnLN
         cGNGz5NQhjzpoda2CDtHxbhRxd7buK3i3pE/novmbCkpg/Pgdv9cuXN3w1uHzYSigl
         VDuUfP+e4Hpbg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210201151245.21845-3-alexandru.ardelean@analog.com>
References: <20210201151245.21845-1-alexandru.ardelean@analog.com> <20210201151245.21845-3-alexandru.ardelean@analog.com>
Subject: Re: [PATCH v3 2/4] clk: clk-axiclkgen: add ZynqMP PFD and VCO limits
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     mturquette@baylibre.com, robh+dt@kernel.org, lars@metafoo.de,
        linux-fpga@vger.kernel.org, mdf@kernel.org, ardeleanalex@gmail.com,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Dragos Bogdan <dragos.bogdan@analog.com>,
        Mathias Tausen <mta@gomspace.com>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 08 Feb 2021 18:29:40 -0800
Message-ID: <161283778087.76967.16810861185434621057@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Quoting Alexandru Ardelean (2021-02-01 07:12:43)
> For ZynqMP (Ultrascale) the PFD and VCO limits are different. In order to
> support these, this change adds a compatible string (i.e.
> 'adi,zynqmp-axi-clkgen-2.00.a')  which will take into account for these
> limits and apply them.
>=20
> Signed-off-by: Dragos Bogdan <dragos.bogdan@analog.com>
> Signed-off-by: Mathias Tausen <mta@gomspace.com>
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> ---

Applied to clk-next
