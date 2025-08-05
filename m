Return-Path: <linux-fpga+bounces-1291-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D70FB1B1A1
	for <lists+linux-fpga@lfdr.de>; Tue,  5 Aug 2025 12:01:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C51A170037
	for <lists+linux-fpga@lfdr.de>; Tue,  5 Aug 2025 10:01:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F157F21C16A;
	Tue,  5 Aug 2025 10:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="U5+98yPu"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B21971E9B2A
	for <linux-fpga@vger.kernel.org>; Tue,  5 Aug 2025 10:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754388076; cv=none; b=LbksHeMw1cFgJunFFwHH5VtqIMnCSRdZuj+bfYqiOHwweQxIfCUvqZDfHijPp5z7QmIWWhjxKXeXMiC+IfsdHByrOp9SQHsuOHJWv9BFWbTh0YWkHPcTt2rW+zTSu3eJMoTCMAoHV6slPJLsQUMSywVJBE191VfdCoaBhrdt/0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754388076; c=relaxed/simple;
	bh=cbccjqYn6yimGLdsMmpNNsUbHzuPfIYsE973tAjuOt8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=HxMeIXeUMErTuDseb9wZSWXMpp4lAifasvF/GMOgvj6R9QIFXVvlArHyeBNp8aPgVGbb+hp71XO/rLd/OL1ml0DwfDSSccX1tAEd4m8w0EqGg3hYBC6mWx0mU7it4PUruOn4+rbrKPozjJwpEYCi3BsM637Ss8MELUbGbwEDMdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=U5+98yPu; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20250805100106euoutp01db8818714dc755ec3707d3df807da532~Y1qazaVrX2512425124euoutp01O
	for <linux-fpga@vger.kernel.org>; Tue,  5 Aug 2025 10:01:06 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20250805100106euoutp01db8818714dc755ec3707d3df807da532~Y1qazaVrX2512425124euoutp01O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1754388066;
	bh=DFXCTOTgC0XZD4i+VdMePOSAvrp8HBKRdAYSOJY0DKE=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=U5+98yPuo/QuOp0QVu8Kf2ZcsbPWRs1R+MpkxzQyGV9ECuIqN36noLxWQM/sDnm/i
	 CV/cGLOwXYt7Ca58vnEchR7dLpa1wdmaRLL7ZllacoT5H2TTpzOm6/4WVswMOsYbpx
	 vns3RAecFefGBl9nypqITBbstwsTOYNWGPrP28HU=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20250805100106eucas1p21037256bfb577e919f0d3d5c0e8da42b~Y1qandZDj1177011770eucas1p2l;
	Tue,  5 Aug 2025 10:01:06 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250805100105eusmtip1df4c738c4ba583ef93ade27b5e51f59d~Y1qZ9wcig2779827798eusmtip1c;
	Tue,  5 Aug 2025 10:01:05 +0000 (GMT)
Message-ID: <a3b997b5-d8b7-4c72-89fc-7d2d21031351@samsung.com>
Date: Tue, 5 Aug 2025 12:01:04 +0200
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: AMD/Xilinx Zynq FPGA manager stopped to work after
 6.16.0-g283564a43383
To: Pavel Pisa <pisa@fel.cvut.cz>
Cc: linux-fpga@vger.kernel.org, Michal Simek <michal.simek@amd.com>, Jason
	Gunthorpe <jgg@nvidia.com>, Xu Yilun <yilun.xu@intel.com>, Pavel Hronek
	<hronepa1@fel.cvut.cz>, Jiri Novak <jnovak@fel.cvut.cz>, Ondrej Ille
	<ondrej.ille@gmail.com>
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <202508041548.22955.pisa@fel.cvut.cz>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20250805100106eucas1p21037256bfb577e919f0d3d5c0e8da42b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250804134826eucas1p1350956e17ae463332a69eaa67dc2f8d7
X-EPHeader: CA
X-CMS-RootMailID: 20250804134826eucas1p1350956e17ae463332a69eaa67dc2f8d7
References: <CGME20250804134826eucas1p1350956e17ae463332a69eaa67dc2f8d7@eucas1p1.samsung.com>
	<202508041548.22955.pisa@fel.cvut.cz>

On 04.08.2025 15:48, Pavel Pisa wrote:
> Hello Marek and others,
>
> we are running daily tests of SocketCAN stack on mainline and RT kernel
> with our CTU CAN FD IP core
>
>     https://canbus.pages.fel.cvut.cz/#can-bus-channels-mutual-latency-testing
>
> It seems that the setup is broken after the mainlie kernel version
> from 2025-07-29, 6.16.0-g283564a43383. There is only one commit
> identified in drivers/fpga after the last working version
>
>    zynq_fpga: use sgtable-based scatterlist wrappers
>
> The last working mainlne kernel version is recorded in the
> last graph data
>
>    https://canbus.pages.fel.cvut.cz/can-latester/inspect.html
>
> We use the dtbocfg out of tree module to initiate update
> by devicetree overlay but fpga manager is mainline one
> and all worked for years correctly. The log messages
>
> [  104.934323] dtbocfg: loading out-of-tree module taints kernel.
> [  104.940681] dtbocfg: 0.1.0
> [  104.943543] dtbocfg: OK
> [  105.022979] fpga_manager fpga0: writing system.bit.bin to Xilinx Zynq FPGA Manager
> [  105.097721] fpga_manager fpga0: Unable to DMA map (TO_DEVICE)
> [  105.103562] fpga_manager fpga0: Error while writing image data to FPGA
> [  105.110485] fpga_region region0: failed to load FPGA image
> [  105.116059] OF: overlay: overlay changeset pre-apply notifier error -12, target: /fpga-full
> [  105.124499] dtbocfg_overlay_item_create: Failed to apply overlay (ret_val=-12)
>
> The overlay source is available there
>
>    https://gitlab.fel.cvut.cz/canbus/zynq/zynq-can-sja1000-top/-/blob/can-bench-2x-xcan-4x-ctu/scripts/dts/bitstream+dt.dts
>
> The base zynq-7000.dtsi could be a little dated, but I have not
> found related change except name/alias change in mainline
>
> -       fpga_full: fpga-full {
> +       fpga_full: fpga-region {
>
> but there are recorded months of correct operation after
> this change. I am aware that there has been change of name
> alias
>
> -       amba: amba {
> +       amba: axi {
>
> in the sources but again, it has not been problem.
>
> It seems that mapping fails in
>
>          priv->dma_nelms =
>              dma_map_sgtable(mgr->dev.parent, sgt, DMA_TO_DEVICE, 0);
>
> The last tested failing mainline kernel version is from this
> midnight
>
>     6.16.0-ge991acf1bce7
>
> Do you have some idea what could be a problem?

Well, my fault. I forgot that dma_map_sgtable() returns only the error 
code or zero on success, not the number of mapped segments. It looks 
that the easiest way to fix this issue is to revert my commit 
37e00703228a ("zynq_fpga: use sgtable-based scatterlist wrappers"). I'm 
sorry for this issue.

> Do you have suggestion what to test?
>
> Best wishes
>
>                  Pavel
>
>                  Pavel Pisa
>      phone:      +420 603531357
>      e-mail:     pisa@cmp.felk.cvut.cz
>      Department of Control Engineering FEE CVUT
>      Karlovo namesti 13, 121 35, Prague 2
>      university: http://control.fel.cvut.cz/
>      personal:   http://cmp.felk.cvut.cz/~pisa
>      social:     https://social.kernel.org/ppisa
>      projects:   https://protect2.fireeye.com/v1/url?k=087d50e3-6906fa6a-087cdbac-74fe48600034-5576b8f5b2b1fa2a&q=1&e=978abd42-4782-42e4-ad5b-318f390cffea&u=https%3A%2F%2Fwww.openhub.net%2Faccounts%2Fppisa
>      CAN related:http://canbus.pages.fel.cvut.cz/
>      RISC-V education: https://comparch.edu.cvut.cz/
>      Open Technologies Research Education and Exchange Services
>      https://gitlab.fel.cvut.cz/otrees/org/-/wikis/home
>
Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland


