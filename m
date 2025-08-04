Return-Path: <linux-fpga+bounces-1290-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 75431B1A3F2
	for <lists+linux-fpga@lfdr.de>; Mon,  4 Aug 2025 15:57:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F13E7AE43E
	for <lists+linux-fpga@lfdr.de>; Mon,  4 Aug 2025 13:56:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 970AC26058D;
	Mon,  4 Aug 2025 13:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fel.cvut.cz header.i=@fel.cvut.cz header.b="fhV5CaW0";
	dkim=pass (2048-bit key) header.d=fel.cvut.cz header.i=@fel.cvut.cz header.b="ar6Kpa82"
X-Original-To: linux-fpga@vger.kernel.org
Received: from smtpx1.feld.cvut.cz (smtpx1.feld.cvut.cz [147.32.210.191])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2214F25C81C
	for <linux-fpga@vger.kernel.org>; Mon,  4 Aug 2025 13:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=147.32.210.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754315846; cv=none; b=RuBE8KWiS3vp66Tx7A0i9lBWi1W1Hacea3ajUHQP+FUkD855YvHvyA1Y8GjX2wfyKGvps5K9wrO1y+LCnSxfnjjNijhdFl3LKoavmpCnFhKxA+bHHKAnTjwgDMJka2eAerTmgfGdce7YU6HghWfNXjnLyqD8+6S9UQn9FdPEnSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754315846; c=relaxed/simple;
	bh=H/P1Fg6XxqRCXFQtwd8pTzggK665IMYvcG+Ob3dA0rU=;
	h=From:To:Subject:Date:Cc:MIME-Version:Content-Type:
	 Content-Disposition:Message-Id; b=b3mfoZTVlyGnT+X8PpL+21hgsfc2aWYOoZUO+/KN1aO8dZcZghJPdwblPkXSf8Kp/KW4RfquElsE4usGfwX2tv2xRFjHiSHZcyAMpc3taVtqlsqpK2UlagZReO6FFlRCorJgHKC/HSGRu3izhKdCBU+Ljy2M/0CF1sRBvMIApEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fel.cvut.cz; spf=pass smtp.mailfrom=fel.cvut.cz; dkim=pass (2048-bit key) header.d=fel.cvut.cz header.i=@fel.cvut.cz header.b=fhV5CaW0; dkim=pass (2048-bit key) header.d=fel.cvut.cz header.i=@fel.cvut.cz header.b=ar6Kpa82; arc=none smtp.client-ip=147.32.210.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fel.cvut.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fel.cvut.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fel.cvut.cz;
	s=felmail; t=1754315295;
	bh=8mfiXx+BaTiLiXSEAibUKyaE1GFC8rrl86WdRP+LNNE=;
	h=From:To:Subject:Date:Cc:From;
	b=fhV5CaW0tuueRLq7UImUI8Ozl5xWzteKXwt1gwXl2yzHmcRORraN597vv0dxXTwOS
	 axEMCRPEE628u0+XMIJFxWEhR5o5r8fhNx1SuRWwFZSbToWgXsdSp7NaWsBzNnbx8u
	 wRTKmjWefT63sZsEvlky9IPL+PTZbILIVt2BdyZtvvAN3x52zEjJSNirN3KB9EZivm
	 ywsb6Tk8XzX7en7gyRyTbIax5gzvw9rgZOkf+3ZmpTZiuL3znJuIGA2YL65Bh/jcny
	 BKCez98CQskKNJULaihVo7qxMBvULJmrLxCmUAiC7aR763CugMgmPO3YFhOt4lyJFf
	 C+Jc/WHSjdp7w==
Received: from smtpx.fel.cvut.cz (smtpx.feld.cvut.cz [147.32.210.153])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtpx1.feld.cvut.cz (Postfix) with ESMTPS id E8CD639ABB;
	Mon,  4 Aug 2025 15:48:15 +0200 (CEST)
Received: from localhost (unknown [192.168.200.27])
	by smtpx.fel.cvut.cz (Postfix) with ESMTP id DE5B5561B8;
	Mon,  4 Aug 2025 15:48:15 +0200 (CEST)
X-Virus-Scanned: IMAP STYX AMAVIS
Received: from smtpx.fel.cvut.cz ([192.168.200.2])
 by localhost (cerokez-250.feld.cvut.cz [192.168.200.27]) (amavis, port 10060)
 with ESMTP id AEfMlIzB89aI; Mon,  4 Aug 2025 15:48:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fel.cvut.cz;
	s=felmail; t=1754315293;
	bh=8mfiXx+BaTiLiXSEAibUKyaE1GFC8rrl86WdRP+LNNE=;
	h=From:To:Subject:Date:Cc:From;
	b=ar6Kpa82FdvW1urG+qoaYGgr5Gk4LiM+KkzII08/Nsj9fW/yzylNRcgHxiC12vLdJ
	 ToZ/ylhe6sNMRLvajrtZsT1cozg9VaJfA/WasCgCD32MmCT7smP9CYlTE94vCazyqP
	 8sfkkYCjoZNgRHfro0lw8QLAsbNpx0db4X8Ov8KRmbyBhwU7KKQl60JnJmMgiYbA9r
	 P3piSmbQqN3DYAiUOnwdLJUgihNY+wtEMDtXfipL3jWQe4iW1lv/IJpwB4PbMVuFvH
	 4lX3ZYDKEQay/j14MutvYEjFexdlk8nD06AhhJEP+Dq9CuABJl0AJceVaiwE711t/B
	 CSt/CDcmkNWQQ==
Received: from baree.pikron.com (static-84-242-78-234.bb.vodafone.cz [84.242.78.234])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pisa)
	by smtpx.fel.cvut.cz (Postfix) with ESMTPSA id 8B4DA55F74;
	Mon,  4 Aug 2025 15:48:11 +0200 (CEST)
From: Pavel Pisa <pisa@fel.cvut.cz>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: AMD/Xilinx Zynq FPGA manager stopped to work after 6.16.0-g283564a43383
Date: Mon, 4 Aug 2025 15:48:22 +0200
User-Agent: KMail/1.9.10
Cc: linux-fpga@vger.kernel.org,
 Michal Simek <michal.simek@amd.com>,
 Jason Gunthorpe <jgg@nvidia.com>,
 Xu Yilun <yilun.xu@intel.com>,
 Pavel Hronek <hronepa1@fel.cvut.cz>,
 Jiri Novak <jnovak@fel.cvut.cz>,
 Ondrej Ille <ondrej.ille@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <202508041548.22955.pisa@fel.cvut.cz>

Hello Marek and others,

we are running daily tests of SocketCAN stack on mainline and RT kernel
with our CTU CAN FD IP core

   https://canbus.pages.fel.cvut.cz/#can-bus-channels-mutual-latency-testing

It seems that the setup is broken after the mainlie kernel version
from 2025-07-29, 6.16.0-g283564a43383. There is only one commit
identified in drivers/fpga after the last working version

  zynq_fpga: use sgtable-based scatterlist wrappers

The last working mainlne kernel version is recorded in the
last graph data 

  https://canbus.pages.fel.cvut.cz/can-latester/inspect.html

We use the dtbocfg out of tree module to initiate update
by devicetree overlay but fpga manager is mainline one
and all worked for years correctly. The log messages

[  104.934323] dtbocfg: loading out-of-tree module taints kernel.
[  104.940681] dtbocfg: 0.1.0
[  104.943543] dtbocfg: OK
[  105.022979] fpga_manager fpga0: writing system.bit.bin to Xilinx Zynq FPGA Manager
[  105.097721] fpga_manager fpga0: Unable to DMA map (TO_DEVICE)
[  105.103562] fpga_manager fpga0: Error while writing image data to FPGA
[  105.110485] fpga_region region0: failed to load FPGA image
[  105.116059] OF: overlay: overlay changeset pre-apply notifier error -12, target: /fpga-full
[  105.124499] dtbocfg_overlay_item_create: Failed to apply overlay (ret_val=-12)

The overlay source is available there

  https://gitlab.fel.cvut.cz/canbus/zynq/zynq-can-sja1000-top/-/blob/can-bench-2x-xcan-4x-ctu/scripts/dts/bitstream+dt.dts

The base zynq-7000.dtsi could be a little dated, but I have not
found related change except name/alias change in mainline

-       fpga_full: fpga-full {
+       fpga_full: fpga-region {

but there are recorded months of correct operation after
this change. I am aware that there has been change of name
alias 

-       amba: amba {
+       amba: axi {

in the sources but again, it has not been problem.

It seems that mapping fails in

        priv->dma_nelms =
            dma_map_sgtable(mgr->dev.parent, sgt, DMA_TO_DEVICE, 0);

The last tested failing mainline kernel version is from this
midnight

   6.16.0-ge991acf1bce7

Do you have some idea what could be a problem?

Do you have suggestion what to test?

Best wishes

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

