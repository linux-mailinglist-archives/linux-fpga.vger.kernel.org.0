Return-Path: <linux-fpga+bounces-919-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A48DF9B345D
	for <lists+linux-fpga@lfdr.de>; Mon, 28 Oct 2024 16:05:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 334B81F229A4
	for <lists+linux-fpga@lfdr.de>; Mon, 28 Oct 2024 15:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D38D1DE3B6;
	Mon, 28 Oct 2024 15:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ia0x8wYP"
X-Original-To: linux-fpga@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49AFC1DD864
	for <linux-fpga@vger.kernel.org>; Mon, 28 Oct 2024 15:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730127927; cv=none; b=S2fPwdPL6Uj1huNn2zNLWxfvgeFZMr65QI8ALA1zAygngYJuc5ofUGNADEHu+2FGuwGveNGVEn7th0zSBh9qFc2fb00eC3wjEPaccOPo824wS5gEic2ooPnaAI3AsS6INcx1NDyCykRaDQ7tC00+uyidliCcEUMQWYqFVrCPs54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730127927; c=relaxed/simple;
	bh=H4+ylYQ1hEj3PJm4OyIODNElBXSkUCICb1o0jm3z+jQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=j7E2jJShw91KnqZyKKApsATwhmJ/RKFwTNoAWZxKqX8Gd2FBEbaw2DheKdqrooX81u9NgMzrguHjx/sTStCFUjTptFQnZBeyTTYlhpTiymEtg/46X+OGKbo9lUIVXGcicblgQUd2f29fX0jEJLqUayaxGU1RIXbqsPo2gpIjFOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ia0x8wYP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730127924;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H4+ylYQ1hEj3PJm4OyIODNElBXSkUCICb1o0jm3z+jQ=;
	b=ia0x8wYP/THL9XOjXakKscfcimXJSIrTe2B5wYQnRQ/ykRUk8jiJxyY6B2X4zEzefpi2H3
	+Cc07rBppa4KEKc20nVBmgwoQj57gcN5PUPWCl0bphG9yiEUJRUMTBKO5m0cy5VzS2fgRk
	k6JEitm1qYcX4WBfqYDTHubspEP27EQ=
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com
 [209.85.221.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-131-buSeN_K3PmqRiPWfm1-zaA-1; Mon, 28 Oct 2024 11:05:23 -0400
X-MC-Unique: buSeN_K3PmqRiPWfm1-zaA-1
Received: by mail-vk1-f197.google.com with SMTP id 71dfb90a1353d-50fa9f5e8d9so4648239e0c.1
        for <linux-fpga@vger.kernel.org>; Mon, 28 Oct 2024 08:05:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730127922; x=1730732722;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H4+ylYQ1hEj3PJm4OyIODNElBXSkUCICb1o0jm3z+jQ=;
        b=j1QAuqEfpLLEonP4Hisd1CpegkgfA58EQABrQdDf+7Ps+bu87osVe8KgFNohFt4LxM
         tLQcKw3rwauHaIWVkKnuaTvB7ekr8humat80jyMFvYg7g2JpBU5jFMku7W3+yMOY3QbJ
         Z9X0O478RlCtag8DAxsUHBM47jDFIUjLUlLDqWksyjcEmt/fqKgkJyvqfDtLwZ+bwsxS
         LRq+dIbZk9KinDNBBcKtmrLpuC4EV2SqPFRPZU/lDpdfq4biYLIGxDsVB5ytIR7GBHIq
         anw2usnJgvxv2KRY16J7z5I10qdL0KLEbhcZ8iUOzN36fhXMpKAHGubb3f7Np7YlIWVg
         GRHQ==
X-Forwarded-Encrypted: i=1; AJvYcCVsJ2cjGUH5Nf5A2d0wZqDD36HdNHZCPOz3o9sdYd/NctkKUwlZ31z9qeysyGB4OebFBfbIIetJtGUp@vger.kernel.org
X-Gm-Message-State: AOJu0YyoGjZtO71SJw0cHkPFr6SCIRBjX2q7H7Blq03dDZiXN98HmVUo
	qKds0b7aplqE4EeU0TSDib6gYzSQpMdD8JssBcnpfMKT6MdsKEv2i/O5+wvQTCX+Otirh1UwUpU
	fAlhoM17Qmcdfi1zauytxm55bq+sWz3BW4pRWfK2x6NMf6rlR6oYdlYnp9lWhGBJJ5O8=
X-Received: by 2002:a05:6122:1688:b0:50c:eb10:9792 with SMTP id 71dfb90a1353d-5104b62308fmr173705e0c.4.1730127921841;
        Mon, 28 Oct 2024 08:05:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFcOyMqz9vSNaECCD5Jog/jP+S1JE0g9vBbOaYmAJuZixiPu4F1kf2Bp8UpkY+b+0W9NOOMaA==
X-Received: by 2002:a05:6214:3c8c:b0:6d1:6fae:6451 with SMTP id 6a1803df08f44-6d19e8862f8mr2136586d6.10.1730127910992;
        Mon, 28 Oct 2024 08:05:10 -0700 (PDT)
Received: from dhcp-64-113.muc.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d179a0c4f2sm32929126d6.95.2024.10.28.08.05.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 08:05:10 -0700 (PDT)
Message-ID: <f1ecab3f7703cd251275ecb141cbb4a24acafa2b.camel@redhat.com>
Subject: Re: [PATCH v8 0/6] PCI: Remove most pcim_iounmap_regions() users
From: Philipp Stanner <pstanner@redhat.com>
To: Jens Axboe <axboe@kernel.dk>, Wu Hao <hao.wu@intel.com>, Tom Rix
 <trix@redhat.com>, Moritz Fischer <mdf@kernel.org>, Xu Yilun
 <yilun.xu@intel.com>,  Andy Shevchenko <andy@kernel.org>, Linus Walleij
 <linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,  Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Bjorn Helgaas
 <bhelgaas@google.com>, Richard Cochran <richardcochran@gmail.com>, Damien
 Le Moal <dlemoal@kernel.org>, Hannes Reinecke <hare@suse.de>, Chaitanya
 Kulkarni <kch@nvidia.com>,  Al Viro <viro@zeniv.linux.org.uk>, Li Zetao
 <lizetao1@huawei.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-fpga@vger.kernel.org, linux-gpio@vger.kernel.org,
 netdev@vger.kernel.org,  linux-pci@vger.kernel.org
Date: Mon, 28 Oct 2024 16:05:06 +0100
In-Reply-To: <20241016094911.24818-2-pstanner@redhat.com>
References: <20241016094911.24818-2-pstanner@redhat.com>
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
Are you OK with taking this?

Regards,
P.

On Wed, 2024-10-16 at 11:49 +0200, Philipp Stanner wrote:
> Merge plan for this is the PCI-Tree.
>=20
> After this series, only two users (net/ethernet/stmicro and
> vdpa/solidrun) will remain to be ported in the subsequent merge
> window.
> Doing them right now proved very difficult because of various
> conflicts
> as they are currently also being reworked.
>=20
> Changes in v8:
> =C2=A0 - Patch "gpio: ..": Fix a bug: don't print the wrong error code.
> (Simon)
> =C2=A0 - Split patch 1 into two patches to make adding of the new public
> API
> =C2=A0=C2=A0=C2=A0 obvious (Bartosz)
> =C2=A0 - Patch "ethernet: cavium: ...": Remove outdated sentences from th=
e
> =C2=A0=C2=A0=C2=A0 commit message.
>=20
> Changes in v7:
> =C2=A0 - Add Paolo's Acked-by.
> =C2=A0 - Rebase on current master; drop patch No.1 which made
> =C2=A0=C2=A0=C2=A0 pcim_request_region() public.
>=20
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
> Philipp Stanner (6):
> =C2=A0 PCI: Make pcim_iounmap_region() a public function
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
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 15 ++++++++-=
------
> =C2=A0.../net/ethernet/cavium/common/cavium_ptp.c=C2=A0=C2=A0=C2=A0 |=C2=
=A0 7 +++----
> =C2=A0drivers/pci/devres.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 8 ++++++--
> =C2=A0include/linux/pci.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 1 +
> =C2=A06 files changed, 30 insertions(+), 35 deletions(-)
>=20


