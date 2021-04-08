Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8A203579EB
	for <lists+linux-fpga@lfdr.de>; Thu,  8 Apr 2021 03:54:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbhDHByj (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 7 Apr 2021 21:54:39 -0400
Received: from mail-pj1-f48.google.com ([209.85.216.48]:55957 "EHLO
        mail-pj1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbhDHByj (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 7 Apr 2021 21:54:39 -0400
Received: by mail-pj1-f48.google.com with SMTP id nh5so275185pjb.5
        for <linux-fpga@vger.kernel.org>; Wed, 07 Apr 2021 18:54:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=SEMD+jWIhf3/qwyBM/4WAt/D/SNE57qBGn/qHwetRTw=;
        b=dPlnEMk+z8oI9+OQqrofSytLi8y7eItQlzE3V3NlGQTcuX9I7nV00F1erIC7YHi5tr
         woO0uCMGraI2+I+r01aCDTkjNtVcirWu80OYWrEXN1TDBwMg9igLhBZsuAu37P2q7NuW
         E9foGDpfBDmFx2cNExyffSWofRqLhiEgnSQih20Ohf0PVUDQC69daBPF+mB7gWcc2ytl
         FBXwohtx7Fw+n7jr9jp3JW33wE8NeFOgMv4D7KyZtCZ7rVizEaGGVxh/dBSwzjhFzY6c
         nqtCtLr4BkgKyNJXCchbjbpdDBrCbG4WB/3VoQpb6/Kdh6dDrzwOOZlWxVKpSWWo9Vru
         TUHg==
X-Gm-Message-State: AOAM532yF/nrNMTkZBklvwlaJ5glLwNyfmLQQPNx6pidoogb1KVXTM55
        XVdVxlB3HnHMnXYepCWv6eSO+S1XSNg=
X-Google-Smtp-Source: ABdhPJyglD9Xg9tLYUcTRxKWsg0udo+Dx9eQPdhdb0L3LgPdN10+JFDAM/ZEy/q/J/V3DwOY7Wi/pQ==
X-Received: by 2002:a17:90b:4b87:: with SMTP id lr7mr5610920pjb.5.1617846868905;
        Wed, 07 Apr 2021 18:54:28 -0700 (PDT)
Received: from localhost ([2601:647:5b00:1162:1ac0:17a6:4cc6:d1ef])
        by smtp.gmail.com with ESMTPSA id a26sm23262095pff.149.2021.04.07.18.54.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Apr 2021 18:54:28 -0700 (PDT)
Date:   Wed, 7 Apr 2021 18:54:29 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-fpga@vger.kernel.org, moritzf@google.com
Subject: [GIT PULL] FPGA Manager addtional 5.13 changes
Message-ID: <YG5iVRIHMRBlorEJ@archbook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

The following changes since commit 6f1e376cfc6864a2f46538db909bbd5253c3c146:

  fpga: Add support for Xilinx DFX AXI Shutdown manager (2021-03-06 07:54:40 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mdf/linux-fpga.git tags/fpga-late-for-5.13

for you to fetch changes up to a78a51a851ed3edc83264a67e2ba77a34f27965f:

  fpga: dfl: pci: add DID for D5005 PAC cards (2021-04-05 17:46:56 -0700)

----------------------------------------------------------------
Second set of FPGA Manager changes for 5.13-rc1

FPGA Manager:
- Russ' first change improves port_enable reliability
- Russ' second change adds a new device ID for a DFL device
- Geert's change updates the examples in binding with dt overlay sugar
  syntax

All patches have been reviewed on the mailing list, and have been in the
last linux-next releases (as part of my for-next branch) without issues.

Signed-off-by: Moritz Fischer <mdf@kernel.org>

----------------------------------------------------------------
Geert Uytterhoeven (1):
      dt-bindings: fpga: fpga-region: Convert to sugar syntax

Russ Weight (2):
      fpga: dfl: afu: harden port enable logic
      fpga: dfl: pci: add DID for D5005 PAC cards

 .../devicetree/bindings/fpga/fpga-region.txt       | 187 ++++++++++-----------
 drivers/fpga/dfl-afu-error.c                       |  10 +-
 drivers/fpga/dfl-afu-main.c                        |  35 ++--
 drivers/fpga/dfl-afu.h                             |   2 +-
 drivers/fpga/dfl-pci.c                             |  18 +-
 5 files changed, 127 insertions(+), 125 deletions(-)
