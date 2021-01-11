Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72E1E2F113D
	for <lists+linux-fpga@lfdr.de>; Mon, 11 Jan 2021 12:23:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729804AbhAKLWJ (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 11 Jan 2021 06:22:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729564AbhAKLWI (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 11 Jan 2021 06:22:08 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32313C061786;
        Mon, 11 Jan 2021 03:21:28 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id p22so18299578edu.11;
        Mon, 11 Jan 2021 03:21:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=jCkNG6d1sS57slG3YOXz4r4g6qRq6UBa2FdiKKF/U8M=;
        b=AvBkVaufXzXIsVdn1YJ4xAeqSkLx8xzFgWYsG4YCOou8z0VtlmhpGf/yqOoxgmzzDW
         /ZeObeuvfUAw8q3QK9OjBUTask/TCMO0f06FPAFjOqw+t31cDrKJYk6CHovnhxbpUPU9
         Bdp1heIK+nQGqlgql8xA0hvzCmSg+2zEsnOYFnX/+lcF2F6LzUsxtt/g8M+12rBrZzsv
         9WG1+hteAwOJLpywSJb5/zx2iVbRaqgq314Uqizfux4YbQH5D38JupGDpdCXhNlTudYI
         JcpHNDz82r3eWTYnpxQnQm46qei5QkPCJkuds5g+23rJWmI9ptte7TuwmB86qf2VD+mQ
         S6kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=jCkNG6d1sS57slG3YOXz4r4g6qRq6UBa2FdiKKF/U8M=;
        b=bigaoHN8I7Rjzzv13lfEBKQ/gO2lB6vIFsV0AzZO/di+UzIvfoWzdbLQAWZI6we4pq
         P/jI5R0cteh2vbW+WD8mH0LSE9O6sL+aqS8VO97Ofmv/tHAHM28ZvH7Sfo9CJiyrkgTd
         X4LKZW96NjIHPOAlT9mx3iimrAJMhwJqN5lVGroHzkEvEx3M+gOsr6qQdsJObTCg2Kzp
         /XzhdQiKMG+XA/VD/rBxeoppS+BT1wZk8UnmVq7SbZnNW2v/Zpv5TknlPT/fGwd3ttqh
         IW6MTEBKOgU7gIPnptsg9Ns7244tzbbbJMP2NrpxQix09GtXr2PracOhOnIQCwh6Q0Zv
         6bmQ==
X-Gm-Message-State: AOAM530YWAfCTRM3dHB2JnGksUJjKA4nuavGFesbBNv5+1CXHDq29mYF
        iaXtQPOmt98SsLnke2AFu/w=
X-Google-Smtp-Source: ABdhPJyAns38qBDE1Lc13bKVIkxB+w9SwLysPYTkgMIasHzSmg6AQ4IEYqKemx29sgueBY5wPJaOew==
X-Received: by 2002:a05:6402:610:: with SMTP id n16mr13422354edv.172.1610364086747;
        Mon, 11 Jan 2021 03:21:26 -0800 (PST)
Received: from felia.fritz.box ([2001:16b8:2d2f:cf00:597a:a5a4:31de:992e])
        by smtp.gmail.com with ESMTPSA id z25sm6833936ejd.23.2021.01.11.03.21.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jan 2021 03:21:26 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wu Hao <hao.wu@intel.com>, Moritz Fischer <mdf@kernel.org>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>,
        linux-fpga@vger.kernel.org
Cc:     Tom Rix <trix@redhat.com>, linux-doc@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH -next] fpga: dfl-pci: rectify ReST formatting
Date:   Mon, 11 Jan 2021 12:21:13 +0100
Message-Id: <20210111112113.27242-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Commit fa41d10589be ("fpga: dfl-pci: locate DFLs by PCIe vendor specific
capability") provides documentation to the FPGA Device Feature List (DFL)
Framework Overview, but introduced new documentation warnings:

  ./Documentation/fpga/dfl.rst:
    505: WARNING: Title underline too short.
    523: WARNING: Unexpected indentation.
    523: WARNING: Blank line required after table.
    524: WARNING: Block quote ends without a blank line; unexpected unindent.

Rectify ReST formatting in ./Documentation/fpga/dfl.rst.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
applies cleanly on next-20210111

Moritz, Matthew, please ack.

Greg, please pick this doc fixup to your fpga -next tree on top of
the commit above.

 Documentation/fpga/dfl.rst | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/fpga/dfl.rst b/Documentation/fpga/dfl.rst
index ea8cefc18bdb..c41ac76ffaae 100644
--- a/Documentation/fpga/dfl.rst
+++ b/Documentation/fpga/dfl.rst
@@ -502,7 +502,7 @@ FME Partial Reconfiguration Sub Feature driver (see drivers/fpga/dfl-fme-pr.c)
 could be a reference.
 
 Location of DFLs on a PCI Device
-===========================
+================================
 The original method for finding a DFL on a PCI device assumed the start of the
 first DFL to offset 0 of bar 0.  If the first node of the DFL is an FME,
 then further DFLs in the port(s) are specified in FME header registers.
@@ -514,6 +514,7 @@ data begins with a 4 byte vendor specific register for the number of DFLs follow
 Offset/BIR vendor specific registers for each DFL. Bits 2:0 of Offset/BIR register
 indicates the BAR, and bits 31:3 form the 8 byte aligned offset where bits 2:0 are
 zero.
+::
 
         +----------------------------+
         |31     Number of DFLS      0|
-- 
2.17.1

