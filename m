Return-Path: <linux-fpga+bounces-775-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A76F39A05F0
	for <lists+linux-fpga@lfdr.de>; Wed, 16 Oct 2024 11:49:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBE491C225F0
	for <lists+linux-fpga@lfdr.de>; Wed, 16 Oct 2024 09:49:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 597A5206942;
	Wed, 16 Oct 2024 09:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NuBUNEA1"
X-Original-To: linux-fpga@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D7D6206042
	for <linux-fpga@vger.kernel.org>; Wed, 16 Oct 2024 09:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729072165; cv=none; b=R4ndaTDFBMwmqcIrDGJeAOWwHJ8DgmT1QUQQxGKdD0wkCJgt7A2wM8rZeasxj1kw8UcCheG+osTa0iU2pL0aSZDfoCP8lqWdg4EfUNqD2K1MnoVZfOD3e8TSs7z44JR5hVSwAMqaSMKpxpNxU9CNZdhw1gyQjRHlv4nJ+TxRmY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729072165; c=relaxed/simple;
	bh=qU40uDWAXxj3oH037Z58Iia9dcS55Em7zzZb741ZWMg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gBXxV7QhLO0SzpvEfslvC5jO9LvEJp22VSBr97i4Za4ZuKDWcBh6rJpm2bp4lpz4pslNFq0UuHA0aASSpzrz7WmCRlhNCkIrgKnpiGabDhMIxpaTM4SjJj8BZy/6cNeAJDDLbm4oMnvhWhoauRvepjR8Ed8pCFsTMIezDe+Z0wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NuBUNEA1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729072162;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=8WNVMc8LDTYNGH+SAKpTHVIymq5YjMjs8ZEPHmIVyE0=;
	b=NuBUNEA1ymRFoOqC8degzz+hqpE5IOwAfQk3mUDc3OJALC1tPwL+BoToNTYJVWUdg2liGT
	R8frBQNZPa8NYjwkq7NyGh0+zNtwrok7+3ykX7PsltFP4DzR8csLUTmklGnS/Dr3smWOe5
	Paey3w7936GjA6tLN2T2IQoXCpQ/T+Q=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-UYp0f71zMPOyomZSW2tTAA-1; Wed, 16 Oct 2024 05:49:19 -0400
X-MC-Unique: UYp0f71zMPOyomZSW2tTAA-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4311407ae76so34363315e9.3
        for <linux-fpga@vger.kernel.org>; Wed, 16 Oct 2024 02:49:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729072158; x=1729676958;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8WNVMc8LDTYNGH+SAKpTHVIymq5YjMjs8ZEPHmIVyE0=;
        b=gAgiXibuG3eNMJDezLy0lbjD5VgoSlOS+gbDQJM8ooxyvI4RWUA6epRCtQdcC4pCmW
         ABaYeggzzwuKwRq/je8LKBJMZydRzyqd1SZLOJSIMkKwHP+LtAY4lmR2wEIIFAnZQKy1
         AVfyIKF+Sl+fZ+/HGHyzdAdmYdYUP8rVe48v7uq9IPiZdWmBck54E8XI/DRFmKc0xtym
         Bx4SCaO5NEL6+OCDLHTaYZyU35eIBFB57qApZBlXcV3kUxJHvwQ4eHM8u2KAY8Wo5qsk
         1D6N8LJLrvXBjtCwjYrrxlc4I2fnRIIGtfOE0eIzhXF9r/v5qQyl6+5Gb7eiqwtiuvnQ
         uoZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUoDBoUS+yWi0kuZOFJ8H8VVCDIU/SjxoKm21OWUjQS9uczC2N/Zy+lORee1rJsKxpS77b7oYTL0BiA@vger.kernel.org
X-Gm-Message-State: AOJu0YwvBTLlOl7t6J1zJUU8vNEzhWgaORO/pNl7VmuA+Q7AbhHzKG+o
	pSVoV2Ms+rLMt1J6nsMBnTPeBpy5oKBGKxNeB0lHIlsyj1La7npzHqu27JVi+HAAwp71qVzEvM3
	7kmjW3qutnGeuFx6mBh7UsM6Dy9uCh4VuboaVJR2Y7NMa8pTu1COT0v+C+Us=
X-Received: by 2002:a05:600c:4688:b0:42f:80f4:ab31 with SMTP id 5b1f17b1804b1-4314a2ff46amr26025595e9.18.1729072158271;
        Wed, 16 Oct 2024 02:49:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHKUDE9oBG3DV9ivNP2q5cTc+CFmH4d6PSgSwWQMyk1ILj67QUdUX0ghs5JR6pQgtk/njtCOw==
X-Received: by 2002:a05:600c:4688:b0:42f:80f4:ab31 with SMTP id 5b1f17b1804b1-4314a2ff46amr26025305e9.18.1729072157791;
        Wed, 16 Oct 2024 02:49:17 -0700 (PDT)
Received: from eisenberg.muc.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4314b32e487sm28190235e9.25.2024.10.16.02.49.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 02:49:17 -0700 (PDT)
From: Philipp Stanner <pstanner@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	Wu Hao <hao.wu@intel.com>,
	Tom Rix <trix@redhat.com>,
	Moritz Fischer <mdf@kernel.org>,
	Xu Yilun <yilun.xu@intel.com>,
	Andy Shevchenko <andy@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Hannes Reinecke <hare@suse.de>,
	Philipp Stanner <pstanner@redhat.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Li Zetao <lizetao1@huawei.com>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fpga@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: [PATCH v8 0/6] PCI: Remove most pcim_iounmap_regions() users
Date: Wed, 16 Oct 2024 11:49:03 +0200
Message-ID: <20241016094911.24818-2-pstanner@redhat.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Merge plan for this is the PCI-Tree.

After this series, only two users (net/ethernet/stmicro and
vdpa/solidrun) will remain to be ported in the subsequent merge window.
Doing them right now proved very difficult because of various conflicts
as they are currently also being reworked.

Changes in v8:
  - Patch "gpio: ..": Fix a bug: don't print the wrong error code. (Simon)
  - Split patch 1 into two patches to make adding of the new public API
    obvious (Bartosz)
  - Patch "ethernet: cavium: ...": Remove outdated sentences from the
    commit message.

Changes in v7:
  - Add Paolo's Acked-by.
  - Rebase on current master; drop patch No.1 which made
    pcim_request_region() public.

Changes in v6:
  - Remove the patches for "vdpa: solidrun" since the maintainer seems
    unwilling to review and discuss, not to mention approve, anything
    that is part of a wider patch series across other subsystems.
  - Change series's name to highlight that not all callers are removed
    by it.

Changes in v5:
  - Patch "ethernet: cavium": Re-add accidentally removed
    pcim_iounmap_region(). (Me)
  - Add Jens's Reviewed-by to patch "block: mtip32xx". (Jens)

Changes in v4:
  - Drop the "ethernet: stmicro: [...] patch since it doesn't apply to
    net-next, and making it apply to that prevents it from being
    applyable to PCI ._. (Serge, me)
  - Instead, deprecate pcim_iounmap_regions() and keep "ethernet:
    stimicro" as the last user for now.
  - ethernet: cavium: Use PTR_ERR_OR_ZERO(). (Andy)
  - vdpa: solidrun (Bugfix) Correct wrong printf string (was "psnet" instead of
    "snet"). (Christophe)
  - vdpa: solidrun (Bugfix): Add missing blank line. (Andy)
  - vdpa: solidrun (Portation): Use PTR_ERR_OR_ZERO(). (Andy)
  - Apply Reviewed-by's from Andy and Xu Yilun.

Changes in v3:
  - fpga/dfl-pci.c: remove now surplus wrapper around
    pcim_iomap_region(). (Andy)
  - block: mtip32xx: remove now surplus label. (Andy)
  - vdpa: solidrun: Bugfix: Include forgotten place where stack UB
    occurs. (Andy, Christophe)
  - Some minor wording improvements in commit messages. (Me)

Changes in v2:
  - Add a fix for the UB stack usage bug in vdap/solidrun. Separate
    patch, put stable kernel on CC. (Christophe, Andy).
  - Drop unnecessary pcim_release_region() in mtip32xx (Andy)
  - Consequently, drop patch "PCI: Make pcim_release_region() a public
    function", since there's no user anymore. (obsoletes the squash
    requested by Damien).
  - vdap/solidrun:
    • make 'i' an 'unsigned short' (Andy, me)
    • Use 'continue' to simplify loop (Andy)
    • Remove leftover blank line
  - Apply given Reviewed- / acked-bys (Andy, Damien, Bartosz)


Important things first:
This series is based on [1] and [2] which Bjorn Helgaas has currently
queued for v6.12 in the PCI tree.

This series shall remove pcim_iounmap_regions() in order to make way to
remove its brother, pcim_iomap_regions().

Regards,
P.

[1] https://lore.kernel.org/all/20240729093625.17561-4-pstanner@redhat.com/
[2] https://lore.kernel.org/all/20240807083018.8734-2-pstanner@redhat.com/

Philipp Stanner (6):
  PCI: Make pcim_iounmap_region() a public function
  PCI: Deprecate pcim_iounmap_regions()
  fpga/dfl-pci.c: Replace deprecated PCI functions
  block: mtip32xx: Replace deprecated PCI functions
  gpio: Replace deprecated PCI functions
  ethernet: cavium: Replace deprecated PCI functions

 drivers/block/mtip32xx/mtip32xx.c              | 18 ++++++++----------
 drivers/fpga/dfl-pci.c                         | 16 ++++------------
 drivers/gpio/gpio-merrifield.c                 | 15 ++++++++-------
 .../net/ethernet/cavium/common/cavium_ptp.c    |  7 +++----
 drivers/pci/devres.c                           |  8 ++++++--
 include/linux/pci.h                            |  1 +
 6 files changed, 30 insertions(+), 35 deletions(-)

-- 
2.47.0


