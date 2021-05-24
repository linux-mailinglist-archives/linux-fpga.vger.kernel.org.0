Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E090B38F181
	for <lists+linux-fpga@lfdr.de>; Mon, 24 May 2021 18:27:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233393AbhEXQ3B (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 24 May 2021 12:29:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60615 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233026AbhEXQ3B (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 24 May 2021 12:29:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621873651;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=4nLMwC8kEWrD6J/dDuglp7fEMPmfCCD3GpnEGOSToTc=;
        b=gsakBZ7pHQo2Z7kpuncHUGUfrlWsT08JjsxEQ1nEZ6aZgmMGXQgGRYawKTic5MSz+M5bEa
        aIZumw+aTYNLY7cBoiZLV9dXT+QZXaBsrNcuA8Icf+H+4ZNuFci3WeHqcWwLjItFImeUkZ
        Ft4L77gs7XqQ7K6hWrOU+WeD9kWtjNU=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-375-ZoogjeJ6Pk2HaxbPu2JU8A-1; Mon, 24 May 2021 12:27:27 -0400
X-MC-Unique: ZoogjeJ6Pk2HaxbPu2JU8A-1
Received: by mail-oo1-f71.google.com with SMTP id e10-20020a4ab14a0000b029020e1573bdb7so17368634ooo.9
        for <linux-fpga@vger.kernel.org>; Mon, 24 May 2021 09:27:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4nLMwC8kEWrD6J/dDuglp7fEMPmfCCD3GpnEGOSToTc=;
        b=W2JJi2hPPd9TKWqEeZEQwx2IUR7RhKsYjqYsH68qA7ZP5w+0lE0oooljphSwUjgyYx
         PhJdwt5LUuogMUxLVEibkXQwHeL2D2Q1T1/65Wi+NB6qDBXwrVeindjsa6btwOBKAOVo
         PGuheTaC+PjnKkg9xgPbw7hJH1PHUg9zrpbpB1nHstHSvHXQvudNvUg0GwmwLEn9xbEY
         dDKBsjTC6qIV/9pIuB4pNoIBaSTeMKKI74z2ZFoN1n3uBimVoSSEcDeoZlgagE1PI4Pa
         AXCicKI4JabZLShdVM9wZ9gWPFqzY26+PkG9TxDjXJ1AsXgE7MUpwwyzbEp/9kuYKDQW
         9VEQ==
X-Gm-Message-State: AOAM5316xi5mVLN0u3PeBn3zhYzPRgMdWab/grLzM+rNLenlpY++bKXZ
        GQHYuPkDFpChLVVfo/0btstHqj3Q++Bq/gfxQ2HBiJUGRFzPLfFSkOCyZh98Ip4/dlMSOJoxUzo
        TDKnkiS84k2zRze1RREpyGQ==
X-Received: by 2002:aca:f354:: with SMTP id r81mr11384669oih.4.1621873646668;
        Mon, 24 May 2021 09:27:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw42exOlTKgikljKyi6YLzzVPK2zjfc1vkxYWZ1pFeN/mqUzEECdUlPHF6iArYGeKhCGoasWg==
X-Received: by 2002:aca:f354:: with SMTP id r81mr11384661oih.4.1621873646515;
        Mon, 24 May 2021 09:27:26 -0700 (PDT)
Received: from localhost.localdomain.com (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id u24sm3171103otg.73.2021.05.24.09.27.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 May 2021 09:27:25 -0700 (PDT)
From:   trix@redhat.com
To:     russell.h.weight@intel.com, mdf@kernel.org, hao.wu@intel.com,
        michal.simek@xilinx.com
Cc:     linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Tom Rix <trix@redhat.com>
Subject: [PATCH v3 0/6] generalize fpga_mgr_load
Date:   Mon, 24 May 2021 09:27:21 -0700
Message-Id: <20210524162721.2220782-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Tom Rix <trix@redhat.com>

A refactor of the fpga-manager to make space for the
functionality of the secure update in this thread.
https://lore.kernel.org/linux-fpga/20210517023200.52707-1-mdf@kernel.org/T/#mf3a1951d429a973c863eee079ed990c55056827c

Splits the reconfig write ops into its own ops structure and
then has an instance for the existing loading (reconfig) and the
secure update (reimage)

fpga_mgr_load uses a new bit, FPGA_MGR_REIMAGE, in fpga_info_info
to use either the reconfig or the reimage ops.

valid write op checking has moved to make the reimage path option.

Since fpga_image_info_alloc zalloc's the fpga_info_struct, the
reimage path will not be taken.

Stub in remimage support for dfl

Changes since v1:
- update op names changed from
  partial_update to reconfig
  full_update to reimage
- dropped the cancel() and get_error() ops.
- add FPGA_MGR_REIMAGE bit
- refactor fpga_mgr_load to use either update ops

Changes since v2:
- Fix a missed write op change
- Stub in dfl reimage

Tom Rix (6):
  fpga: generalize updating the card
  fpga: add FPGA_MGR_REIMAGE flag
  fpga: pass fpga_manager_update_ops to the fpga_manager_write functions
  fpga: defer checking for update ops until they are used
  fpga: use reimage ops in fpga_mgr_load()
  fpga: dfl: stub in reimaging

 drivers/fpga/altera-cvp.c        |  8 ++--
 drivers/fpga/altera-pr-ip-core.c |  8 ++--
 drivers/fpga/altera-ps-spi.c     |  8 ++--
 drivers/fpga/dfl-fme-mgr.c       | 38 ++++++++++++++---
 drivers/fpga/dfl-fme-pr.c        | 40 +++++++++++-------
 drivers/fpga/fpga-mgr.c          | 72 ++++++++++++++++++++------------
 drivers/fpga/ice40-spi.c         |  8 ++--
 drivers/fpga/machxo2-spi.c       |  8 ++--
 drivers/fpga/socfpga-a10.c       | 10 ++---
 drivers/fpga/socfpga.c           |  8 ++--
 drivers/fpga/stratix10-soc.c     |  8 ++--
 drivers/fpga/ts73xx-fpga.c       |  8 ++--
 drivers/fpga/xilinx-spi.c        |  8 ++--
 drivers/fpga/zynq-fpga.c         | 10 ++---
 drivers/fpga/zynqmp-fpga.c       |  8 ++--
 include/linux/fpga/fpga-mgr.h    | 35 +++++++++++-----
 include/uapi/linux/fpga-dfl.h    | 18 ++++++--
 17 files changed, 192 insertions(+), 111 deletions(-)

-- 
2.26.3

