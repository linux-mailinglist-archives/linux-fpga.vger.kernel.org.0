Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAF573E0437
	for <lists+linux-fpga@lfdr.de>; Wed,  4 Aug 2021 17:32:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239013AbhHDPcS (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 4 Aug 2021 11:32:18 -0400
Received: from mail-wr1-f42.google.com ([209.85.221.42]:44689 "EHLO
        mail-wr1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238879AbhHDPcL (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 4 Aug 2021 11:32:11 -0400
Received: by mail-wr1-f42.google.com with SMTP id z4so2709566wrv.11
        for <linux-fpga@vger.kernel.org>; Wed, 04 Aug 2021 08:31:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding;
        bh=svQc8sYX2DEcQJ1PiowUbLw4ZfZS5jTZovwEP9WdYGA=;
        b=kIwiTBCjA+OpccGzgYdxW+bM1t9WL1RNc1BUX9BPhGEQhC8wHRbfdtZBTeBcvPlf+U
         knWC1tfeTD/DiPJ8ipkvReiMYk27Ae67gqIHKtWeUV0LZcZv6Io79qzqTH5qkcJH3jDs
         OQ8lcghV0fwibwhMK6YGwMk1P+5+g9id84Grcz58Y1g/NKAtMulpke/DBGx9yHMVUi1r
         kQnqt8aVWqMlzXnuY3ixpvZGG/3kooca8e7g3OR8uDx4j0MYd0OkTaifyWMnmwAdLMQF
         uMJOfU49lLnhwxH+kqjUtOXxNS2D5bxRQpQ/L35FQTTQxPOE+KnEI4WYQdjqsvuNcioV
         AlRw==
X-Gm-Message-State: AOAM531XWyGR+hUpUtEo4hR+DCPaofmQ07Ak6dLI5/KVMTt9AQI3wm7b
        UO4bXW8WZ5l9Ga6o8xaxopg=
X-Google-Smtp-Source: ABdhPJyo1YHjtmWRk/YqvTnYJrvdmCjuIQuofbHPoYtJYDMDh9Seizg3OBRca46kZ/wK2BXU9f/yVw==
X-Received: by 2002:a05:6000:11c8:: with SMTP id i8mr30055838wrx.300.1628091115556;
        Wed, 04 Aug 2021 08:31:55 -0700 (PDT)
Received: from localhost ([149.172.45.165])
        by smtp.gmail.com with ESMTPSA id n11sm3481791wrs.81.2021.08.04.08.31.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Aug 2021 08:31:54 -0700 (PDT)
Date:   Wed, 4 Aug 2021 08:31:54 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-fpga@vger.kernel.org, moritzf@google.com
Subject: [GIT PULL] FPGA Manager changes for 5.15-rc1
Message-ID: <YQqy6mso7Ukf6NYq@archbook>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

The following changes since commit 630211a17055bafd21fb83ae8c0002b2e214ebb2:

  fpga: fpga-mgr: wrap the write_sg() op (2021-07-24 15:10:31 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mdf/linux-fpga.git tags/fpga-for-5.15

for you to fetch changes up to 4f45f3404960109843eaa92c8a4a850d6bdd9981:

  spi: spi-altera-dfl: support n5010 feature revision (2021-07-29 13:02:28 -0700)

----------------------------------------------------------------
FPGA Manager changes for 5.15-rc1

FPGA Manager

- Colin's change is a simple spelling cleanup.

DFL

- Martin's fist change exposes DFL feature revision to client drivers
- Martin's second change modifies a SPI driver to populate different
  spi_board_info modaliases based on the DFL feature revision

All patches have been reviewed on the mailing list, and have been in the
last few linux-next releases (as part of my for-next branch) without issues.

Signed-off-by: Moritz Fischer <mdf@kernel.org>

----------------------------------------------------------------
Colin Ian King (1):
      fpga: Fix spelling mistake "eXchnage" -> "exchange" in Kconfig

Martin Hundebøll (2):
      fpga: dfl: expose feature revision from struct dfl_device
      spi: spi-altera-dfl: support n5010 feature revision

 drivers/fpga/Kconfig         |  2 +-
 drivers/fpga/dfl.c           | 27 +++++++++++++++++----------
 drivers/fpga/dfl.h           |  1 +
 drivers/spi/spi-altera-dfl.c | 21 ++++++++++++---------
 include/linux/dfl.h          |  1 +
 5 files changed, 32 insertions(+), 20 deletions(-)
