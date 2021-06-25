Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6ACED3B498A
	for <lists+linux-fpga@lfdr.de>; Fri, 25 Jun 2021 21:59:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229878AbhFYUBW (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 25 Jun 2021 16:01:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:30298 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229853AbhFYUBU (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Fri, 25 Jun 2021 16:01:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624651139;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=cKZbkTJmpGtN/IdbnoPTOQJqZouuD1FRtyZb5ELX/mU=;
        b=YtzLuHq7RfBylLXJa/mnGITCnvGTZtBDnRYN2kkoK4vqbvFwi/4UCvrln68NOJR7UxpYjX
        r45tSn+EEPNzSA3o2C63LjGUmuL4LoerH31iH8UhcpdYOuhGIRRRchkEpyzGwtvDR7wQCY
        uUkMSaebESP5e6ScZ5Bn5tjnxmUWh9Y=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-558-zW1nlEWtPIO1X0OHuOvacw-1; Fri, 25 Jun 2021 15:58:56 -0400
X-MC-Unique: zW1nlEWtPIO1X0OHuOvacw-1
Received: by mail-oi1-f197.google.com with SMTP id n84-20020acaef570000b029022053bcedd7so6511495oih.17
        for <linux-fpga@vger.kernel.org>; Fri, 25 Jun 2021 12:58:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cKZbkTJmpGtN/IdbnoPTOQJqZouuD1FRtyZb5ELX/mU=;
        b=IbOlMRPzpZ4CpPcDFgpSmZE7nHZSZJ8RbtQOWo+iKMLC3Q/OD6I7Set1bQZI2K5Bmm
         IKHLyJaZdyIAVUXdGD/yqN96wHI3GJO0HfgnuznWFBos9F9nx/zPl+Tl84yXVIidJCsm
         ZXc4CidE57d9O726mwm+aE8uhFDVkYh8o4odu8dm5L3sWjzx/HM2+E3/bBXs7MKX7Tzm
         hsSj4SlgD+sha2qVQAQQyxX+m6HGqxP0SFdhaJrU0WMHq6LO3YQHsO/hJYFItrol/bH2
         FildF6eLXXLqtm3eixSB7sCGTzrXbZT7nH5Qho9RioqY6xDzQ1ggTH5XCbRinBctDQzd
         8x8w==
X-Gm-Message-State: AOAM531V5IjcXW4B9BMj6D5Yi2XDg3lUymR4S/XN5VDk7ruv/wI3i4Mt
        U2/CMmUVZIHkct/NgHs5LZDQgv3MH0De11XaSLenREPrmK3T9T4SxdtEKqI7KG6iXu+ufLTSm6H
        LCHV8lLrbG0Uj1uR4X5vGpQ==
X-Received: by 2002:a54:440a:: with SMTP id k10mr12678112oiw.59.1624651136187;
        Fri, 25 Jun 2021 12:58:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzjWad8+91HNuP1vH4HhgSb+cVNKVucceXg2FsrIECVnI0lomtdR0fS8FNKnfz3l2lhsugMCA==
X-Received: by 2002:a54:440a:: with SMTP id k10mr12678101oiw.59.1624651136006;
        Fri, 25 Jun 2021 12:58:56 -0700 (PDT)
Received: from localhost.localdomain.com (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id r204sm1467374oih.11.2021.06.25.12.58.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jun 2021 12:58:55 -0700 (PDT)
From:   trix@redhat.com
To:     mdf@kernel.org, hao.wu@intel.com, michal.simek@xilinx.com
Cc:     linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Tom Rix <trix@redhat.com>
Subject: [PATCH v5 0/4]  generalize fpga_mgr_load
Date:   Fri, 25 Jun 2021 12:58:44 -0700
Message-Id: <20210625195849.837976-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Tom Rix <trix@redhat.com>

Depends on
https://lore.kernel.org/linux-fpga/20210625195148.837230-9-trix@redhat.com/

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

Changes since v3
- refactor for wrapper ops patchset
- drop 0004 fpga: defer checking.., wrapper ops took care of that
- drop 0006 fpga: dfl stub in..., simplify the patchset
- add a wrapper for write_sg
- rearrange the passing of update ops to be last.
- simplify some wrapper checks, this should go in the wrapper ps.

Changes since v4
- refactor for wrapper ops patchset
- drop write_sg wrapper
- drop 'fpga: fpga-mgr: simplify mops check in wrappers'


Tom Rix (4):
  fpga: generalize updating the card
  fpga: add FPGA_MGR_REIMAGE flag
  fpga: pass fpga_manager_update_ops to the fpga_manager_write functions
  fpga: use reimage ops in fpga_mgr_load()

 drivers/fpga/altera-cvp.c        |  8 +--
 drivers/fpga/altera-pr-ip-core.c |  8 +--
 drivers/fpga/altera-ps-spi.c     |  8 +--
 drivers/fpga/dfl-fme-mgr.c       |  8 +--
 drivers/fpga/fpga-mgr.c          | 95 +++++++++++++++++++-------------
 drivers/fpga/ice40-spi.c         |  8 +--
 drivers/fpga/machxo2-spi.c       |  8 +--
 drivers/fpga/socfpga-a10.c       | 10 ++--
 drivers/fpga/socfpga.c           |  8 +--
 drivers/fpga/stratix10-soc.c     |  6 +-
 drivers/fpga/ts73xx-fpga.c       |  6 +-
 drivers/fpga/xilinx-spi.c        |  8 +--
 drivers/fpga/zynq-fpga.c         | 10 ++--
 drivers/fpga/zynqmp-fpga.c       |  6 +-
 include/linux/fpga/fpga-mgr.h    | 35 ++++++++----
 15 files changed, 132 insertions(+), 100 deletions(-)

-- 
2.26.3

