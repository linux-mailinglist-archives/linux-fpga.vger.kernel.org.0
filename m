Return-Path: <linux-fpga+bounces-707-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0910D969A6A
	for <lists+linux-fpga@lfdr.de>; Tue,  3 Sep 2024 12:42:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F0C21C23437
	for <lists+linux-fpga@lfdr.de>; Tue,  3 Sep 2024 10:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB2A11B9859;
	Tue,  3 Sep 2024 10:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="StHQuN1Q"
X-Original-To: linux-fpga@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 090D41B984E
	for <linux-fpga@vger.kernel.org>; Tue,  3 Sep 2024 10:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725360123; cv=none; b=Shj+vdrogDB75SlnWKOcooLZFmFTXohXuABJP2wfXb6BnZeuslR1zef6f6XDIRynlVn1T6lKlcffMaZzUS2dcvWfjFu9NtR9TXjIa5g09a9S0d5vnri3gaDkH/MEWw6E9HTJJrGMJpic1BV93AlPbKutOGFz/OyVkP/hhl3GjPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725360123; c=relaxed/simple;
	bh=qbizLx7wTCAOjESO9AyVt8wu2rYiD1MB9P9cW5S88ys=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rA7/wPBEAGQ2uGgU7+9hFU5+vvLuQQr5HIy2mWtZqwGhRO8Qp9x6QZAEkm72WqQMc7x1p36KwYloTEhgOTpFQhPMZb7krAnQzo3G27A7DOd2kiYzIE7tUTWuOk9QG0iZG1k90D12Os/Lp8DSVtm49G2OoA/UKiCaZ4gGvwE/5Dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=StHQuN1Q; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725360121;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qbizLx7wTCAOjESO9AyVt8wu2rYiD1MB9P9cW5S88ys=;
	b=StHQuN1Q4Lpr2+32/uyt+Fy8NtfKpK0LQeXMBTWYxpLA379ekHaVK3zeyzgj1XiH9r9gAB
	o0cGomtufNc6WLbrTa+N5JG8eHYpOfgS/PxcK9AH5DQEaSwOyze2ML/FwKwrqwBA4x7P52
	VzZagYTuRjkuN3xSj0gvEG8lkQ+lF6o=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-486-cnpMKW82OhaluQlX7qT-jA-1; Tue, 03 Sep 2024 06:41:59 -0400
X-MC-Unique: cnpMKW82OhaluQlX7qT-jA-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-42bb9fa67d7so49555835e9.0
        for <linux-fpga@vger.kernel.org>; Tue, 03 Sep 2024 03:41:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725360118; x=1725964918;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qbizLx7wTCAOjESO9AyVt8wu2rYiD1MB9P9cW5S88ys=;
        b=YtlfRyIio87xpnrW+v0ooueTZixNX9xPSvWu9FR9EHXGT3/GVorDkn6MMXUsaDYxHH
         hwgwNUOVB0a+NYpG2Py3WT2sf6lTvk0M476XyXSBfU6hmntAUAQAyNL89xpyf7MKoKEH
         E6nw8SCGJ90i+MXAp64ftuPV4j1wPh3u+VFD9YbsTrVVkRATdsm9u3mToDP6yFeUJ4pN
         B7RrBSlsFv6LYlMcQuEI6ubTgBE8XJ41qZleKJtY430XH281dVU7rOVEfe/b/j4clBGG
         0a1G8U6R8GVNlhUivrcvg45v38c53XfpRFndkiUP3oD/znXCc/3m+bR3RF/Shl03ZCN2
         lwZA==
X-Forwarded-Encrypted: i=1; AJvYcCVmT1J/rXRmA25k4wJiGB5gKaVG2dFsgTX1IoZJeXo0L8FWvGcSdS28gNNhWtjq2d8VsHQUvGKxa4/R@vger.kernel.org
X-Gm-Message-State: AOJu0YxoYvk1xxrWGS1uYufyMpdCHSY/Hizu0ZJ7dS6Ws4QTa9DWh1XD
	Ht4hcrA4rxJyNX8NmWpJ+YOH80f37s0XsWxT7CuFKYBnJamlfvXaIACXkubEQ6c+p5oYqaCdxTX
	0KMhgFehf5so6mQ+LzTb8tT7s/sa+kSteGCQCu91wpbn7m6RYV8JrQk42Lrk=
X-Received: by 2002:a05:600c:354b:b0:426:545b:ec00 with SMTP id 5b1f17b1804b1-42bb01c1c17mr144186095e9.19.1725360118343;
        Tue, 03 Sep 2024 03:41:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHnJ+QTA8ZKsd8rfiT6e8FYacEzmTRgtvYSZ2cF3fvYtWB375xRT2pTBy4x3T4AFjvx4VWFiw==
X-Received: by 2002:a05:600c:354b:b0:426:545b:ec00 with SMTP id 5b1f17b1804b1-42bb01c1c17mr144185575e9.19.1725360117728;
        Tue, 03 Sep 2024 03:41:57 -0700 (PDT)
Received: from dhcp-64-16.muc.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42bb6f9b584sm165397125e9.16.2024.09.03.03.41.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 03:41:57 -0700 (PDT)
Message-ID: <5c5c2970fa4b23b348663873771e65a2cd78fcaf.camel@redhat.com>
Subject: Re: [PATCH v6 0/5] PCI: Remove most pcim_iounmap_regions() users
From: Philipp Stanner <pstanner@redhat.com>
To: Jens Axboe <axboe@kernel.dk>, Wu Hao <hao.wu@intel.com>, Tom Rix
 <trix@redhat.com>, Moritz Fischer <mdf@kernel.org>, Xu Yilun
 <yilun.xu@intel.com>,  Andy Shevchenko <andy@kernel.org>, Linus Walleij
 <linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,  Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Bjorn Helgaas
 <bhelgaas@google.com>, Richard Cochran <richardcochran@gmail.com>, Damien
 Le Moal <dlemoal@kernel.org>, Hannes Reinecke <hare@suse.de>, John Garry
 <john.g.garry@oracle.com>, Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-fpga@vger.kernel.org, linux-gpio@vger.kernel.org,
 netdev@vger.kernel.org,  linux-pci@vger.kernel.org
Date: Tue, 03 Sep 2024 12:41:55 +0200
In-Reply-To: <20240902062342.10446-2-pstanner@redhat.com>
References: <20240902062342.10446-2-pstanner@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Because someone asked:
The proposed merge plan for this series would be to take it through the
PCI tree, as was done with similar cleanups during the last months.

Cheers,
P.


On Mon, 2024-09-02 at 08:23 +0200, Philipp Stanner wrote:
> Changes in v6:
> =C2=A0 - Remove the patches for "vdpa: solidrun" since the maintainer
> seems
> =C2=A0=C2=A0=C2=A0 unwilling to review and discuss, not to mention approv=
e, anything
> =C2=A0=C2=A0=C2=A0 that is part of a wider patch series across other subs=
ystems.
> =C2=A0 - Change series's name to highlight that not all callers are
> removed
> =C2=A0=C2=A0=C2=A0 by it.
>=20
> Changes in v5:
> =C2=A0 - Patch "ethernet: cavium": Re-add accidentally removed
> =C2=A0=C2=A0=C2=A0 pcim_iounmap_region(). (Me)
> =C2=A0 - Add Jens's Reviewed-by to patch "block: mtip32xx". (Jens)
>=20
> Changes in v4:
> =C2=A0 - Drop the "ethernet: stmicro: [...] patch since it doesn't apply
> to
> =C2=A0=C2=A0=C2=A0 net-next, and making it apply to that prevents it from=
 being
> =C2=A0=C2=A0=C2=A0 applyable to PCI ._. (Serge, me)
> =C2=A0 - Instead, deprecate pcim_iounmap_regions() and keep "ethernet:
> =C2=A0=C2=A0=C2=A0 stimicro" as the last user for now.
> =C2=A0 - ethernet: cavium: Use PTR_ERR_OR_ZERO(). (Andy)
> =C2=A0 - vdpa: solidrun (Bugfix) Correct wrong printf string (was "psnet"
> instead of
> =C2=A0=C2=A0=C2=A0 "snet"). (Christophe)
> =C2=A0 - vdpa: solidrun (Bugfix): Add missing blank line. (Andy)
> =C2=A0 - vdpa: solidrun (Portation): Use PTR_ERR_OR_ZERO(). (Andy)
> =C2=A0 - Apply Reviewed-by's from Andy and Xu Yilun.
>=20
> Changes in v3:
> =C2=A0 - fpga/dfl-pci.c: remove now surplus wrapper around
> =C2=A0=C2=A0=C2=A0 pcim_iomap_region(). (Andy)
> =C2=A0 - block: mtip32xx: remove now surplus label. (Andy)
> =C2=A0 - vdpa: solidrun: Bugfix: Include forgotten place where stack UB
> =C2=A0=C2=A0=C2=A0 occurs. (Andy, Christophe)
> =C2=A0 - Some minor wording improvements in commit messages. (Me)
>=20
> Changes in v2:
> =C2=A0 - Add a fix for the UB stack usage bug in vdap/solidrun. Separate
> =C2=A0=C2=A0=C2=A0 patch, put stable kernel on CC. (Christophe, Andy).
> =C2=A0 - Drop unnecessary pcim_release_region() in mtip32xx (Andy)
> =C2=A0 - Consequently, drop patch "PCI: Make pcim_release_region() a
> public
> =C2=A0=C2=A0=C2=A0 function", since there's no user anymore. (obsoletes t=
he squash
> =C2=A0=C2=A0=C2=A0 requested by Damien).
> =C2=A0 - vdap/solidrun:
> =C2=A0=C2=A0=C2=A0 =E2=80=A2 make 'i' an 'unsigned short' (Andy, me)
> =C2=A0=C2=A0=C2=A0 =E2=80=A2 Use 'continue' to simplify loop (Andy)
> =C2=A0=C2=A0=C2=A0 =E2=80=A2 Remove leftover blank line
> =C2=A0 - Apply given Reviewed- / acked-bys (Andy, Damien, Bartosz)
>=20
>=20
> Important things first:
> This series is based on [1] and [2] which Bjorn Helgaas has currently
> queued for v6.12 in the PCI tree.
>=20
> This series shall remove pcim_iounmap_regions() in order to make way
> to
> remove its brother, pcim_iomap_regions().
>=20
> Regards,
> P.
>=20
> [1]
> https://lore.kernel.org/all/20240729093625.17561-4-pstanner@redhat.com/
> [2]
> https://lore.kernel.org/all/20240807083018.8734-2-pstanner@redhat.com/
>=20
> Philipp Stanner (5):
> =C2=A0 PCI: Deprecate pcim_iounmap_regions()
> =C2=A0 fpga/dfl-pci.c: Replace deprecated PCI functions
> =C2=A0 block: mtip32xx: Replace deprecated PCI functions
> =C2=A0 gpio: Replace deprecated PCI functions
> =C2=A0 ethernet: cavium: Replace deprecated PCI functions
>=20
> =C2=A0drivers/block/mtip32xx/mtip32xx.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 18 ++++++++--------
> --
> =C2=A0drivers/fpga/dfl-pci.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 | 16 ++++------------
> =C2=A0drivers/gpio/gpio-merrifield.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 14 +++++++--=
-----
> =C2=A0.../net/ethernet/cavium/common/cavium_ptp.c=C2=A0=C2=A0=C2=A0 |=C2=
=A0 7 +++----
> =C2=A0drivers/pci/devres.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 8 ++++++--
> =C2=A0include/linux/pci.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 1 +
> =C2=A06 files changed, 29 insertions(+), 35 deletions(-)
>=20


