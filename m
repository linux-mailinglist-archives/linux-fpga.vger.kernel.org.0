Return-Path: <linux-fpga+bounces-1335-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5C80B32B81
	for <lists+linux-fpga@lfdr.de>; Sat, 23 Aug 2025 20:46:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 968CE177AB3
	for <lists+linux-fpga@lfdr.de>; Sat, 23 Aug 2025 18:46:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 640491FA859;
	Sat, 23 Aug 2025 18:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fel.cvut.cz header.i=@fel.cvut.cz header.b="f4gW3Yfk";
	dkim=pass (2048-bit key) header.d=fel.cvut.cz header.i=@fel.cvut.cz header.b="iIviQtDl"
X-Original-To: linux-fpga@vger.kernel.org
Received: from smtpx1.feld.cvut.cz (smtpx1.feld.cvut.cz [147.32.210.191])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC5B1C68F;
	Sat, 23 Aug 2025 18:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=147.32.210.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755974777; cv=none; b=QDInK0EmVAgYjJEU7mg7p4QaOTKgRkUM8uVb5j6lTAquiwuOaibiDZ0Ke/p0BCfmYO6ze80Pnjd8wKtSx/QcjPqVwI3NrSUMn+h42BYOb3ppPO/ANN+rSRaW6zqtS+XoinDVG5M8zEOmzhalciZleeIg8JcOkfUYkMqmIuJKm48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755974777; c=relaxed/simple;
	bh=Gv08LVg4Is4sI70oQSivDwFlbOxt1u+zZMU7nmyy8Hc=;
	h=From:To:Subject:Date:Cc:References:In-Reply-To:MIME-Version:
	 Content-Type:Content-Disposition:Message-Id; b=sBtxnFigjze2aDMxICo0Q27o3L7MN8ByJWJipQ9XZdU9PQ7E3r787iS5VY7EzbuzR1TF2ei11TaKJ6f7zaJbpZR6LuiyWWL1T1Wqzinhznp20z3EMVg1dISDOLXJb1H+JqzG+ufCXIXDj39HoqweJX/sH4cmd4Q/4FlTLulfNAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fel.cvut.cz; spf=pass smtp.mailfrom=fel.cvut.cz; dkim=pass (2048-bit key) header.d=fel.cvut.cz header.i=@fel.cvut.cz header.b=f4gW3Yfk; dkim=pass (2048-bit key) header.d=fel.cvut.cz header.i=@fel.cvut.cz header.b=iIviQtDl; arc=none smtp.client-ip=147.32.210.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fel.cvut.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fel.cvut.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fel.cvut.cz;
	s=felmail; t=1755974766;
	bh=GWyvweIb1JyZkTmvgrhr6qu32/9cCyU5G73MBwYSDs0=;
	h=From:To:Subject:Date:Cc:References:In-Reply-To:From;
	b=f4gW3YfkFpS/1RXTuODCAT5XevzfITFfLWz+8QZWZ6brYknmsvXbrkkFhC5qi5rfL
	 fW4faOjkiezDbEAh15/oV4qHOfjSzwTqEeXu+mO+aQBwOoYGiu5fYAgnsHrLo94DG8
	 GdIPRKbZ5uTndCLmdZKfQlkleby0sej6nFzY1hM7ezX9OFBM7CM9eGdIAhu+yUVhGj
	 F2na6qCYsa3Bdl+0nba4Fzun/BGgqgNCmoKqM+vE2kvEpbjWnwuMkUohZLnETY2Tqc
	 S2yv6L343maC4kHTpG+jRqNQCz+LASmEvTDkrl47xxK6cGe0XQCuPNtDYzb3+Fq8UN
	 QzR3D7uafo7Yg==
Received: from smtpx.fel.cvut.cz (smtpx.feld.cvut.cz [147.32.210.153])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtpx1.feld.cvut.cz (Postfix) with ESMTPS id 59A802FAE9;
	Sat, 23 Aug 2025 20:46:06 +0200 (CEST)
Received: from localhost (unknown [192.168.200.27])
	by smtpx.fel.cvut.cz (Postfix) with ESMTP id 4F87C4C934;
	Sat, 23 Aug 2025 20:46:06 +0200 (CEST)
X-Virus-Scanned: IMAP STYX AMAVIS
Received: from smtpx.fel.cvut.cz ([192.168.200.2])
 by localhost (cerokez-250.feld.cvut.cz [192.168.200.27]) (amavis, port 10060)
 with ESMTP id mzU6X5CqklqA; Sat, 23 Aug 2025 20:46:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fel.cvut.cz;
	s=felmail; t=1755974376;
	bh=GWyvweIb1JyZkTmvgrhr6qu32/9cCyU5G73MBwYSDs0=;
	h=From:To:Subject:Date:Cc:References:In-Reply-To:From;
	b=iIviQtDl+LWm2EBh3PME8bjPMKW384sLcI8TJGYk395+z9NEUucV6GLs6VcZBHcWq
	 gViJCQvHt1Q8hRYHio6RAeV3CZAdrvyik371ujtzxWzr8a+1bnv0jJGXirISX1VHWt
	 GeNDp8WtIdOpV+A4BFQmwi8+5D4pAfnYAAT2eyJNzD/LtMzkyN5/l3nb9hpY+6/F/R
	 hOReyWiJiAdBNIZsFNv9BvJYesKumhe0ErsJHgZps1m04/azqbvY8nD3Yx7Qjab8gT
	 rOrQi2Xu/K3hGzTyxOhnAiEaEGkIAM7iVv5i+WKgxZnt8lhihjEe7UIIhvhoOa7SlI
	 zjRH4Pb84tVaQ==
Received: from baree.pikron.com (static-84-242-78-234.bb.vodafone.cz [84.242.78.234])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pisa)
	by smtpx.fel.cvut.cz (Postfix) with ESMTPSA id BDAB84C852;
	Sat, 23 Aug 2025 20:39:33 +0200 (CEST)
From: Pavel Pisa <pisa@fel.cvut.cz>
To: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 1/1] fpga: zynq_fpga: Fix the wrong usage of dma_map_sgtable()
Date: Sat, 23 Aug 2025 20:39:37 +0200
User-Agent: KMail/1.9.10
Cc: Xu Yilun <yilun.xu@linux.intel.com>,
 jgg@nvidia.com,
 m.szyprowski@samsung.com,
 yilun.xu@intel.com,
 linux-fpga@vger.kernel.org,
 mdf@kernel.org,
 linux-kernel@vger.kernel.org,
 Michal Simek <michal.simek@amd.com>,
 "Marc Kleine-Budde" <mkl@pengutronix.de>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>
References: <20250806070605.1920909-1-yilun.xu@linux.intel.com> <202508190039.02454.pisa@fel.cvut.cz> <2025081907-wireless-entail-08d5@gregkh>
In-Reply-To: <2025081907-wireless-entail-08d5@gregkh>
X-KMail-QuotePrefix: > 
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <202508232039.37632.pisa@fel.cvut.cz>

Hello Greg,

On Tuesday 19 of August 2025 07:25:57 Greg KH wrote:
> On Tue, Aug 19, 2025 at 12:39:02AM +0200, Pavel Pisa wrote:
> > I have analyzed the cause and reported (August 4) that mainline
> > Zynq runtime FPGA bitstream loading was broken by patch
> >
> >   37e00703228a ("zynq_fpga: use sgtable-based scatterlist wrappers")
> >
....

> It's in my "to apply" queue to get to for 6.17-final.
>
> Please give us a chance to catch up, August is usually a time for
> vacations :)

Thanks lot for the pushing the patch

  fpga: zynq_fpga: Fix the wrong usage of dma_map_sgtable()

into the Linux kernel mainline. I report success - the mainline
is not stuck after FPGA reconfiguration and CTU CAN FD tests
progress to successful finish for mainline kernel.

The exact tested version

   6.17.0-rc2-g8d245acc1e88+flood-kern-fd-thrd-load

In the fact, I have noticed that your pull request has been applied
by Linus at 8/23/25 5:27 PM and I have invoked the CAN latester
build queue by had to provide feedback as soon as possible.
It is triggered after CEST midnight normally with results
available next day at the morning.

As for the stable queues (from your e-mail notices), please,
ensure that both patches are applied or none.

As for our whole test round results together with the RT kernel, we do not
reach functional state yet because the problematic patch has propagated
to RT kernel and kernel fails hard way after boot and reconfigure
script invocation now.

When FPGA configuration is skipped and then run manually on RT,
I get

[  233.319355] dtbocfg: loading out-of-tree module taints kernel.
[  233.319999] dtbocfg: 0.1.0
[  233.320105] dtbocfg: OK
[  233.435010] fpga_manager fpga0: writing system.bit.bin to Xilinx Zynq FPGA Manager
[  233.510549] fpga_manager fpga0: Unable to DMA map (TO_DEVICE)
[  233.510567] fpga_manager fpga0: Error while writing image data to FPGA
[  233.510951] fpga_region region0: failed to load FPGA image
[  233.510967] OF: overlay: overlay changeset pre-apply notifier error -12, target: /fpga-full

We build the branch "for-kbuild-bot/current-stable" from
git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git
The actual version

  6.17.0-rc1-rt1-gf54787e29f62

We can switch to another branch or reintroduce some patching
in the automatic process which we have there in the past.

By the way, I have done the first OpenOCD accesses/registers
dumps of our CTU CAN FD IP core on ESP32-C5 to see how it has
propagated to real silocon. We are buying some CAN FD
transceivers in DIL package for initial wire nest
soldering on a bread board now. 

Best wishes,

                Pavel

                Pavel Pisa
    phone:      +420 603531357
    e-mail:     pisa@cmp.felk.cvut.cz
    Department of Control Engineering FEE CVUT
    Karlovo namesti 13, 121 35, Prague 2
    university: http://control.fel.cvut.cz/
    personal:   http://cmp.felk.cvut.cz/~pisa
    social:     https://social.kernel.org/ppisa
    projects:   https://www.openhub.net/accounts/ppisa
    CAN related:http://canbus.pages.fel.cvut.cz/
    RISC-V education: https://comparch.edu.cvut.cz/
    Open Technologies Research Education and Exchange Services
    https://gitlab.fel.cvut.cz/otrees/org/-/wikis/home

