Return-Path: <linux-fpga+bounces-758-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7853994F2B
	for <lists+linux-fpga@lfdr.de>; Tue,  8 Oct 2024 15:25:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B49AB2674F
	for <lists+linux-fpga@lfdr.de>; Tue,  8 Oct 2024 13:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F1551DED6F;
	Tue,  8 Oct 2024 13:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TBFwvvvf"
X-Original-To: linux-fpga@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC151DE3C1
	for <linux-fpga@vger.kernel.org>; Tue,  8 Oct 2024 13:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728393419; cv=none; b=Ycy8/p8Yrww1jOZcNUaDODIYh/HzRCHV+8rni5y7eKRs/bmSYnkWghpQ4aQPwFci7hTqXvXAtbQDZoGA3qlw0cn5vHHfsUCW44w9Ame4UZogn64eRwbBb2+Ksq30XoozgHvvfR41Eaa4HZVfxddmQqWhB/yoJKoHRgEfYF5TjnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728393419; c=relaxed/simple;
	bh=4qzCr/863Vf+2oDWeHcab0ZGKqVZCNqD9ak/lC92cUE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=boMkqeuu+YhVMWIjCY0EHulS1S5qXUCuI2vO6Bnsoix2txRHrqjCs8YWp5r/7TBplDUFsCwzTN/n6zcaqkcgfK1fMblbJ0sC5DvVRgo+Fiju9HWSh5uFktaxLqNGdJOMPD+jjsEDnmZ566L3Ai5tNfYVC3u77ZzxnSV4LeEdb5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TBFwvvvf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728393417;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4qzCr/863Vf+2oDWeHcab0ZGKqVZCNqD9ak/lC92cUE=;
	b=TBFwvvvfiEKSd/wLzyHYxjIyBfyPSmI0bgfa0TkLC+o9UVLJJ2J50IjOE28+JwFYQ1RmmQ
	a3yXaFvpq/iYtYS3vAqZqnTpW6kuqaIc0js3E0Vzt0S5jeenDoaK5c5EJV9OHnjTE3++Kc
	kosdJbIdM8Ffp3Vp+dsE8bEk0gyyiGc=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-107-WZqb7bbBMdWiDjPPS_2-Dw-1; Tue, 08 Oct 2024 09:16:56 -0400
X-MC-Unique: WZqb7bbBMdWiDjPPS_2-Dw-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-5c9166079c0so154883a12.3
        for <linux-fpga@vger.kernel.org>; Tue, 08 Oct 2024 06:16:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728393415; x=1728998215;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4qzCr/863Vf+2oDWeHcab0ZGKqVZCNqD9ak/lC92cUE=;
        b=tONGozI+bwED6CBIkMCMZGwbjPjXznFQbOS8pRL2ueUl2Mwjjjua4zbG16deU9Os9c
         L1PcMEUi0F5z/Y5bfWIKORKboSk409so/oIL83I/T93ed5Y0XTiUwbBfkHjXdwX4D+JP
         pnOY7cgKXYGAWto9ttfApef/0A3mMwO1e319zPt+rBH1yGmGgQ8VurvsO/skhBa/szx4
         gRwyYTyQsyh3LsPYtPddZ7qnBE2TyVD2ER42h0yqGCXJBF2iaJ/ZybA3SOGBHF9vSJzL
         cKN8bZnkSNuz61OxU5UDLURXkEbF3qjNJkFidhRseJWP/OEfHE90FH0D5+tkVfu3zifw
         JVdA==
X-Forwarded-Encrypted: i=1; AJvYcCX525Bq5sd6deR/FLbnvJGLTynqIvP6EBpVBT6xjgzDb9hsLlALKLJ7jLMSiFIgHE3VfvhGS21MZ+I0@vger.kernel.org
X-Gm-Message-State: AOJu0YxohwaTp0SyR51OfkqNLMH1ZJFQfg/7uiHjIWTrEVm2JaD1rm3m
	ZrXgNSn75U/rjnGC8OjlAGJl1GvoVvrYcWBnmDwklbdoXdr6MeEGLEAisCXQ1JOmfdYbbQ0ADTX
	mw9hm9XpyfAyiK9RWvD0FZeJHsI/pXW1J1AH4WfUbtxPJ3Dw++rJGwbZf1Ik=
X-Received: by 2002:a17:907:3e05:b0:a93:d5d3:be4 with SMTP id a640c23a62f3a-a991bd16c3fmr1579990166b.13.1728393414767;
        Tue, 08 Oct 2024 06:16:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHEFEZcrmlRMftqLlmOZSsoDK/ZCIPnc3OiarQfc2zlGz6X81vFDMyJSw+zoGP5nEXTggdgtw==
X-Received: by 2002:a17:907:3e05:b0:a93:d5d3:be4 with SMTP id a640c23a62f3a-a991bd16c3fmr1579987666b.13.1728393414320;
        Tue, 08 Oct 2024 06:16:54 -0700 (PDT)
Received: from eisenberg.fritz.box (200116b82d43760013399881f4bcf5cb.dip.versatel-1u1.de. [2001:16b8:2d43:7600:1339:9881:f4bc:f5cb])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a993ed35544sm441427066b.73.2024.10.08.06.16.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 06:16:53 -0700 (PDT)
Message-ID: <dfe23f1344f0a74d05d5a605aa78c5989be22619.camel@redhat.com>
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
Date: Tue, 08 Oct 2024 15:16:52 +0200
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

@Bjorn:

How do you feel about this for v6.13? :)

All Reviews / Acks are in place.

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


