Return-Path: <linux-fpga+bounces-685-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5108C9647E3
	for <lists+linux-fpga@lfdr.de>; Thu, 29 Aug 2024 16:19:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0901C2813FD
	for <lists+linux-fpga@lfdr.de>; Thu, 29 Aug 2024 14:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 295D92BD19;
	Thu, 29 Aug 2024 14:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B9j4hdm1"
X-Original-To: linux-fpga@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C8F242A96
	for <linux-fpga@vger.kernel.org>; Thu, 29 Aug 2024 14:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724941134; cv=none; b=lwOIUlxyqeSemjHVITjBpPU+RZTJ0kGhnivrkJBEfHI7RB/nr9nNU71YqvNLmf1uZcYhwtyccH47graNuy1IYIgq2I7EgHOXZnpikQZi1XikasRN4pFGYKVGcHTne/iB7/KUFvnFxNxrf4w+2YsYsdq1MmluDrC7dZvH1bwxATo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724941134; c=relaxed/simple;
	bh=bN72jrToXfY+vJucKr9xb19mZvJ9IN7YKnm5yOK/+sI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NVQlA3HETKZVYAKPWh1LM9W5Ih5Apzd2mD+RXzp3xv1nxdnG91NXAnTNHJN+VUjy+EQ3SLzY+RESP2iU4RRC8BBDK5rHTdS2btLExRtISMSW29/s4v7/smpSEKNmErN2+Wi6EJow6TjeoJeASliDvnrFP507f6Y7uRfKRgH0A6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=B9j4hdm1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724941131;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=UljbUeQcl4wkbV7mOtS08F4hh+nFyo1TBvQFl+wrPVQ=;
	b=B9j4hdm1OAj0oVwR13xBqHISjAHCGVkyutH9wkan0z9m9/R+qzptmO0Z6pxIrUkAUeWdYJ
	qGjT/mxFR1TvHW3ZK5cGBmpJmHxxfLL9PGT/8YVS8dIEGN3iO2zQmssCmPnzRnk78ofB6H
	xCmStquSUWYeaQGiIEV+EKVVMbhX3Bk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-Vs7R8-eXOMGnaOwzl72FaQ-1; Thu, 29 Aug 2024 10:18:50 -0400
X-MC-Unique: Vs7R8-eXOMGnaOwzl72FaQ-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-428076fef5dso7326485e9.2
        for <linux-fpga@vger.kernel.org>; Thu, 29 Aug 2024 07:18:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724941128; x=1725545928;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UljbUeQcl4wkbV7mOtS08F4hh+nFyo1TBvQFl+wrPVQ=;
        b=YTnTaksYcVtO96wV2aO7uzgV4WhxgGMrqDdAxV9+8ale+IjcsmPvgvDk08dHX0oM26
         5bIauI5uGU/4MUED8CXadO0/uMUkfn8HrR+/M+h/DG8v+tSCdlExfSgPz7/qW0uU8dVp
         RN7j94VwakSyNIygJEemTK7a8E2e1dcoB3WvQfl0Q8pxnvDscdMv3tfqGjaoGFpbEAYn
         L2SWce3gCXRd1GLmFEzaXTNf0G65JSt/RGXFgFhSij5aKXaOdfEYyvon5ifimsulx6EC
         8YXxyqeOPxL1S0h8cixLNKRSXH0JGFoW/iKUCEpzhqGfBk7icsoYFB78WDTSteZM0SN9
         e04g==
X-Forwarded-Encrypted: i=1; AJvYcCVaUre+v2+DUm5kXDxlG0+76m4I/1sGUjKlGyUGJWqMz5WpauYaHu51GBL/7XEgQIciPhtDqUDkgKiE@vger.kernel.org
X-Gm-Message-State: AOJu0Ywwl8oO49rLQiEdy3iHanmOr13SFGbhlFqdrz17nDMV5OqFEhts
	o7FsQKre9l2pDbmtj5v5Oumbzkudxd0jPtzQtluKaw6njvmIjMmjv0exsLFauKr+eADmpjoBtdU
	q/mxQ/fGblswJYnCIEm61DwlIH8OEHVHpiv4K1BGAYJUAaSEW2R5XgkmIM6Y=
X-Received: by 2002:a05:600c:470f:b0:428:9ba:39f with SMTP id 5b1f17b1804b1-42bb024d9d6mr24548595e9.11.1724941128524;
        Thu, 29 Aug 2024 07:18:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHaWAd/dk5mVFnN9RDmi+8yHhRiBHqeSEZqBrS5gu6xo2wvJc2Dt1Hm0EPgbT3w2rGsknEV9A==
X-Received: by 2002:a05:600c:470f:b0:428:9ba:39f with SMTP id 5b1f17b1804b1-42bb024d9d6mr24548445e9.11.1724941127865;
        Thu, 29 Aug 2024 07:18:47 -0700 (PDT)
Received: from eisenberg.muc.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ba63abebdsm52670425e9.27.2024.08.29.07.18.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 07:18:47 -0700 (PDT)
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
	Alvaro Karsz <alvaro.karsz@solid-run.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Hannes Reinecke <hare@suse.de>,
	John Garry <john.g.garry@oracle.com>,
	Philipp Stanner <pstanner@redhat.com>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fpga@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-pci@vger.kernel.org,
	virtualization@lists.linux.dev
Subject: [PATCH v5 0/7] PCI: Remove pcim_iounmap_regions()
Date: Thu, 29 Aug 2024 16:16:19 +0200
Message-ID: <20240829141844.39064-1-pstanner@redhat.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

OK, so unfortunately it seems very challenging to reconcile the merge
conflict pointed up by Serge between net-next and pci-devres regarding
"ethernet: stmicro": A patch that applies to the net-next tree does not
apply anymore to pci-devres (and vice versa).

So I actually think that it would be best if we just drop the portation
of "ethernet: stmicro" for now and port it as the last user in v6.13.

Then we can also remove pcim_iounmap_regions() completely.

That should then be trivial.

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

@Bjorn: Feel free to squash the PCI commits.

Regards,
P.

[1] https://lore.kernel.org/all/20240729093625.17561-4-pstanner@redhat.com/
[2] https://lore.kernel.org/all/20240807083018.8734-2-pstanner@redhat.com/

Philipp Stanner (7):
  PCI: Deprecate pcim_iounmap_regions()
  fpga/dfl-pci.c: Replace deprecated PCI functions
  block: mtip32xx: Replace deprecated PCI functions
  gpio: Replace deprecated PCI functions
  ethernet: cavium: Replace deprecated PCI functions
  vdpa: solidrun: Fix UB bug with devres
  vdap: solidrun: Replace deprecated PCI functions

 drivers/block/mtip32xx/mtip32xx.c             | 18 +++---
 drivers/fpga/dfl-pci.c                        | 16 ++---
 drivers/gpio/gpio-merrifield.c                | 14 ++---
 .../net/ethernet/cavium/common/cavium_ptp.c   |  7 +--
 drivers/pci/devres.c                          |  8 ++-
 drivers/vdpa/solidrun/snet_main.c             | 59 ++++++++-----------
 include/linux/pci.h                           |  1 +
 7 files changed, 53 insertions(+), 70 deletions(-)

-- 
2.46.0


