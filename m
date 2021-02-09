Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14739314648
	for <lists+linux-fpga@lfdr.de>; Tue,  9 Feb 2021 03:30:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbhBIC3e (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 8 Feb 2021 21:29:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:60776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229587AbhBIC3c (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 8 Feb 2021 21:29:32 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id F247E64E82;
        Tue,  9 Feb 2021 02:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612837731;
        bh=ltRKezZA+bzg59reTb4OPH9B4ojvzcmnt7bDRcRVAwQ=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=H8VPTz1UW3XMN94ITOcOekOLmX61o+vShlC2odIm7xFvQMF0Wwsb4a7pUxXKBJHlW
         4kYXnYAVjofuhP+MpFtTf6KvfkpAWmffs5ea3unYaryxkll93ijRTsXdIZORvROmOZ
         eA4E5K+KX9vdvJufDFeSNoew6J/UUGImq07FK17dV2vE/8rs/xYKiIZLX2cAvTcJ76
         BGxG2sTJBvS2xBO8YbTbWUW4LUlT1iJMWaZbWeZMvrgQXjOnTwQnRldRa1Utd4NKCB
         9AzYDqNaCSFiJmVVsqMyD34ClmaRw4Ke+VbDHl8VQuMbK+B3Zh7PKmv4xef+ryu7Jc
         IlCDuJ2JGPadQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210201151245.21845-2-alexandru.ardelean@analog.com>
References: <20210201151245.21845-1-alexandru.ardelean@analog.com> <20210201151245.21845-2-alexandru.ardelean@analog.com>
Subject: Re: [PATCH v3 1/4] clk: axi-clkgen: replace ARCH dependencies with driver deps
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     mturquette@baylibre.com, robh+dt@kernel.org, lars@metafoo.de,
        linux-fpga@vger.kernel.org, mdf@kernel.org, ardeleanalex@gmail.com,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Dragos Bogdan <dragos.bogdan@analog.com>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 08 Feb 2021 18:28:49 -0800
Message-ID: <161283772966.76967.9816955224774608075@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Quoting Alexandru Ardelean (2021-02-01 07:12:42)
> The intent is to be able to run this driver to access the IP core in setu=
ps
> where FPGA board is also connected via a PCIe bus. In such cases the numb=
er
> of combinations explodes, where the host system can be an x86 with Xilinx
> Zynq/ZynqMP/Microblaze board connected via PCIe.
> Or even a ZynqMP board with a ZynqMP/Zynq/Microblaze connected via PCIe.
>=20
> To accommodate for these cases, this change removes the limitation for th=
is
> driver to be compilable only on Zynq/Microblaze architectures.
> And adds dependencies on the mechanisms required by the driver to work (OF
> and HAS_IOMEM).
>=20
> Signed-off-by: Dragos Bogdan <dragos.bogdan@analog.com>
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> ---

Applied to clk-next
