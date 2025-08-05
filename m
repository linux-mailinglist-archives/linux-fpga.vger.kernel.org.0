Return-Path: <linux-fpga+bounces-1294-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D9D5B1BB14
	for <lists+linux-fpga@lfdr.de>; Tue,  5 Aug 2025 21:41:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A7BE164116
	for <lists+linux-fpga@lfdr.de>; Tue,  5 Aug 2025 19:41:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19C5529B8E4;
	Tue,  5 Aug 2025 19:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fel.cvut.cz header.i=@fel.cvut.cz header.b="cbxw+Ib/";
	dkim=pass (2048-bit key) header.d=fel.cvut.cz header.i=@fel.cvut.cz header.b="D2l3gWlp"
X-Original-To: linux-fpga@vger.kernel.org
Received: from smtpx1.feld.cvut.cz (smtpx1.feld.cvut.cz [147.32.210.191])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0779329A333
	for <linux-fpga@vger.kernel.org>; Tue,  5 Aug 2025 19:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=147.32.210.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754422818; cv=none; b=aXuxq1fB/Y+A7s3lhrAyT2s67hdPt7WXGQHz2thVaUqmHBn7KTqEskkAi3Qi3Jy06SqwqIOZITgDxssg8r3S7o7KNXTIa9oGP2AzTlHbg+h6juyX2xrDvzx8ufjC8HCrrq4b/z7nQBa10pqHXGMmFsTHL+HecOcw0hVA6+MnFJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754422818; c=relaxed/simple;
	bh=CsRnQp/poyhVnwY6zThmlzmcvmidcnbbznfQ3C7eOVw=;
	h=From:To:Subject:Date:Cc:References:In-Reply-To:MIME-Version:
	 Content-Type:Content-Disposition:Message-Id; b=Fl94JtSv5Oql/nbSDYQJDkcNYSOP5bfcmAGww3hBxFptndvJd64OsTwBbxdeHKWx8kv1/eIyJG4wcYWvCUZNz6ZXNazl6oFTxb+80GmliKoOWAWuQBnsZLh0nufqe9pm3GKq7Wnep8lZ7IqbfOVQZhefOqO0zjppWBErrdJLoC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fel.cvut.cz; spf=pass smtp.mailfrom=fel.cvut.cz; dkim=pass (2048-bit key) header.d=fel.cvut.cz header.i=@fel.cvut.cz header.b=cbxw+Ib/; dkim=pass (2048-bit key) header.d=fel.cvut.cz header.i=@fel.cvut.cz header.b=D2l3gWlp; arc=none smtp.client-ip=147.32.210.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fel.cvut.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fel.cvut.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fel.cvut.cz;
	s=felmail; t=1754422806;
	bh=+9Tx4Khj/lvU1t/5l7IvmWKmOE3UXYziTFRKwiOaVW4=;
	h=From:To:Subject:Date:Cc:References:In-Reply-To:From;
	b=cbxw+Ib/lpMRy0d8v8BIpkH2SfGQJ97TBXoN5TBqf0hmNEelKbkfUHGL9l9KWHnlf
	 T64EDk8UluKzRrxKqOd4WpOzAAiRqJVT1Rs7p3dz+7EFaoaFrwBLoOH+umNHhRo99I
	 /BnoATCiCD0PYEE4lAZFym0a09335Ef/F3CmqnyaU8fgs/+MHirIoRTyLxhZFLobph
	 iBPgEqYd48njx8GNVoGA9b5hbUtOHeyeRgvm1tF6p9V9JOWrzDaqx105/DCm3ZAWHy
	 qhlmB9EpOIE0xRpVrVtdwVo0djQOJL6asBQI6uLv67ofXVn06dAzsB3YJVFGnfd4Up
	 lNYkCsYX5gcfw==
Received: from smtpx.fel.cvut.cz (smtpx.feld.cvut.cz [147.32.210.153])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtpx1.feld.cvut.cz (Postfix) with ESMTPS id 5F7E43A9AE;
	Tue,  5 Aug 2025 21:40:06 +0200 (CEST)
Received: from localhost (unknown [192.168.200.27])
	by smtpx.fel.cvut.cz (Postfix) with ESMTP id 5618E14896;
	Tue,  5 Aug 2025 21:40:06 +0200 (CEST)
X-Virus-Scanned: IMAP STYX AMAVIS
Received: from smtpx.fel.cvut.cz ([192.168.200.2])
 by localhost (cerokez-250.feld.cvut.cz [192.168.200.27]) (amavis, port 10060)
 with ESMTP id PZDAGApY_EfI; Tue,  5 Aug 2025 21:40:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fel.cvut.cz;
	s=felmail; t=1754422803;
	bh=+9Tx4Khj/lvU1t/5l7IvmWKmOE3UXYziTFRKwiOaVW4=;
	h=From:To:Subject:Date:Cc:References:In-Reply-To:From;
	b=D2l3gWlptmTk1i5PiDWfgIn0EZ/mLbnwB4B3F1FWN23GPNWyC/82XvZIXd90k6Gvj
	 Y4M2bn5XBNMQgEsN5/zSSfoS5G/9Hig8kviFs5wEIA8rWvG3IEOfbe35arAs31jkWV
	 Lv4zOZK8E4HwvLIKKC/Ij267MmjFCt88PLx82irI4ikbxsOms2wiAhak14rEtZ+I9n
	 kR0u9KRelZkSxcI+KoD1K1yL3J6h2lPEfqjGZEll9YvYcjfNDfXUAZJiiyBSFXwGu5
	 7ZSpbbO1IsSuWhqqVxu1+VCo9S3IWpBFptcuBa3sjC2sAJ9EJBqncf/sSasryBKDP6
	 r9H0FG0600Sxg==
Received: from [10.0.2.63] (unknown [80.188.199.122])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pisa)
	by smtpx.fel.cvut.cz (Postfix) with ESMTPSA id 4A751144F7;
	Tue,  5 Aug 2025 21:40:01 +0200 (CEST)
From: Pavel Pisa <pisa@fel.cvut.cz>
To: Jason Gunthorpe <jgg@nvidia.com>,
 Xu Yilun <yilun.xu@linux.intel.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: AMD/Xilinx Zynq FPGA manager stopped to work after 6.16.0-g283564a43383
Date: Tue, 5 Aug 2025 21:39:59 +0200
User-Agent: KMail/1.9.10
Cc: linux-fpga@vger.kernel.org,
 Michal Simek <michal.simek@amd.com>,
 Xu Yilun <yilun.xu@intel.com>,
 Pavel Hronek <hronepa1@fel.cvut.cz>,
 Jiri Novak <jnovak@fel.cvut.cz>,
 Ondrej Ille <ondrej.ille@gmail.com>
References: <CGME20250804134826eucas1p1350956e17ae463332a69eaa67dc2f8d7@eucas1p1.samsung.com> <aJI7juhONZp/8XfI@yilunxu-OptiPlex-7050> <20250805185235.GP184255@nvidia.com>
In-Reply-To: <20250805185235.GP184255@nvidia.com>
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
Message-Id: <202508052140.00023.pisa@fel.cvut.cz>

Hello all

On Tuesday 05 of August 2025 20:52:35 Jason Gunthorpe wrote:
> On Wed, Aug 06, 2025 at 01:12:46AM +0800, Xu Yilun wrote:
> > @@ -405,12 +405,12 @@ static int zynq_fpga_ops_write(struct fpga_manager
> > *mgr, struct sg_table *sgt) }
> >         }
> >
> > -       priv->dma_nelms =
> > -           dma_map_sgtable(mgr->dev.parent, sgt, DMA_TO_DEVICE, 0);
> > -       if (priv->dma_nelms == 0) {
> > +       err = dma_map_sgtable(mgr->dev.parent, sgt, DMA_TO_DEVICE, 0);
> > +       if (err) {
> >                 dev_err(&mgr->dev, "Unable to DMA map (TO_DEVICE)\n");
> > -               return -ENOMEM;
> > +               return err;
> >         }
> > +       priv->dma_nelms = sgt->nents;
>
> That looks pretty good, Marek is certainly right the original had a
> bug.
>
> Jason

Thanks for the fast correction proposal. I have tested the change
at our kernel build, actual mainline version form midnight
rebuild with patch now

  Linux mzapo 6.16.0+ #2 SMP Tue Aug  5 20:59:36 CEST 2025 armv7l GNU/Linux

and it works correctly, DTBOCFG and FPGA manager is able to load
CTU CAN FD IP core design and then driver is loaded and its instances
are setup according to the device tree overlay and driver detects
CAN controllers implemented in FPGA. I have not run whole CAN test
sequence but I do not expect problems there. You can add my

Reported-by: Pavel Pisa <pisa@fel.cvut.cz>
Tested-by: Pavel Pisa <pisa@fel.cvut.cz>

Do you have some idea how fast can the change propagate
into mainline? I would setup automatic patching with
the fix if the testing setup is broken for some longer time.
If the fix can get in mainline in days or week then I would
spent time on that.

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

