Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5AD464B0D4
	for <lists+linux-fpga@lfdr.de>; Wed, 19 Jun 2019 06:26:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725800AbfFSE0J (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 19 Jun 2019 00:26:09 -0400
Received: from mail-pf1-f171.google.com ([209.85.210.171]:44145 "EHLO
        mail-pf1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725562AbfFSE0J (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 19 Jun 2019 00:26:09 -0400
Received: by mail-pf1-f171.google.com with SMTP id t16so8920168pfe.11;
        Tue, 18 Jun 2019 21:26:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QoqBjbnbVUFwMYkr5z+V32BVGTNOgEPS/FwsUKHAFD0=;
        b=KSlgmLDg+LxjtVHtxwgG4i3W2vGHe7b6vPg4o5Fzy2AVh0vrj2vr8nXjTAiLnB+Q52
         jjiEMR9woyOKNuN+21BJPZOl3h+8nHSK+Mkrgmv9Othfas4EVg/8jPJkMxHJuRAiwgZ9
         y5RMUXAwR7gRwhQkXtQyQ2VGR4jCXEikVQeDlydN2ferQAIhXkqdOkBh4FtRWP7F4Cvi
         DVQGD/3i59sq2djewgOKuHhfFKS9nHjIEiltWG4yYY0oUnA/8loKdzDg/KEPoKBfst2D
         q5RX80WGdhirhzno76UXTwac92fkxBXLA0K6bVEvojW4e0kDfg34Efdzd49lLR4NvA1k
         U/8w==
X-Gm-Message-State: APjAAAVGmqrB5+XFr6B/YViHNV88xpTM3Rdo7yLtc2McrH2fNQFrC4rv
        wZ1aNfIIrFn/vT1EF/6fUPU=
X-Google-Smtp-Source: APXvYqzhcRhQ6/iZ+KboLx/bqN4KhxhVOIObEu9kJjgVVnnQ/tlzOBNxDfqLRYyg6EDJXcOquXnElg==
X-Received: by 2002:a65:5889:: with SMTP id d9mr5803789pgu.39.1560918368425;
        Tue, 18 Jun 2019 21:26:08 -0700 (PDT)
Received: from localhost ([2601:647:4700:b8cd:7726:b947:9a25:6e35])
        by smtp.gmail.com with ESMTPSA id v10sm11805711pfe.163.2019.06.18.21.26.07
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 18 Jun 2019 21:26:07 -0700 (PDT)
From:   Moritz Fischer <mdf@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        atull@kernel.org, Moritz Fischer <mdf@kernel.org>
Subject: [PATCH 0/1] One cleanup patch for FPGA
Date:   Tue, 18 Jun 2019 21:24:38 -0700
Message-Id: <20190619042439.4705-1-mdf@kernel.org>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi Greg,

please take this cleanup patch.
It's been on the list but somehow fell through the cracks.

Thanks,
Moritz

Enrico Weigelt (1):
  drivers: fpga: Kconfig: pedantic cleanups

 drivers/fpga/Kconfig | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

-- 
2.22.0

