Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 197742F5BAC
	for <lists+linux-fpga@lfdr.de>; Thu, 14 Jan 2021 08:55:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbhANHyn (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 14 Jan 2021 02:54:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:56650 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726893AbhANHyb (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 14 Jan 2021 02:54:31 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id CEAE5239EB;
        Thu, 14 Jan 2021 07:53:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610610830;
        bh=BfR7Hw4xHA9KGq6SfRhpALDGRDIIsusN8JYXc3PJDIw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=O8lxQtJjlauI3y2svqA6PtVEQTUJtxAUN44am9OR9/B6Gqsh+TIdUopujBFRW2u6/
         kw+u0RHEX1yAqDMtLk48sCWxYdYKgJZhTky+gOmKjy5AZwts3IjXdjKzXCHZcEqcOv
         8Cs02hl6wt8kYTr+1PAVLlkFYwV2w3DQUMtNU25tiJRIb23vJNvjVZgXyDFhU+QNgf
         6shX0bJS4j8hsmJIZW812x8Uux3ip9lRoW2sTIxfkIwJ3C16sYNrjx1nMas9PsFDDY
         B9KhELqUHhHnV3Cae6uPS2upkb076CDL+v5i4pFbj5dPTCEvSnDmNDWRBzEhIBtUB8
         lH+9dmF9g4usA==
Received: by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kzxRz-00EPuB-85; Thu, 14 Jan 2021 08:53:47 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>, Moritz Fischer <mdf@kernel.org>,
        Wu Hao <hao.wu@intel.com>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Linux Doc Mailing List" <linux-doc@vger.kernel.org>,
        Tom Rix <trix@redhat.com>, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 05/10] docs: fpga: dfl.rst: Fix a couple building issues
Date:   Thu, 14 Jan 2021 08:53:40 +0100
Message-Id: <fca8e53692b1e57242e09fc3436cacd1961c8d8b.1610610444.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1610610444.git.mchehab+huawei@kernel.org>
References: <cover.1610610444.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

A title markup length is smaller than required;
A literal block is not marked as such.

This fixes the warnings below:

    .../Documentation/fpga/dfl.rst:505: WARNING: Title underline too short.

    Location of DFLs on a PCI Device
    ===========================
    .../Documentation/fpga/dfl.rst:523: WARNING: Unexpected indentation.
    .../Documentation/fpga/dfl.rst:523: WARNING: Blank line required after table.
    .../Documentation/fpga/dfl.rst:524: WARNING: Block quote ends without a blank line; unexpected unindent.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/fpga/dfl.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/fpga/dfl.rst b/Documentation/fpga/dfl.rst
index ea8cefc18bdb..716a3d705046 100644
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
@@ -513,7 +513,7 @@ VSEC ID of 0x43 for this purpose.  The vendor specific
 data begins with a 4 byte vendor specific register for the number of DFLs followed 4 byte
 Offset/BIR vendor specific registers for each DFL. Bits 2:0 of Offset/BIR register
 indicates the BAR, and bits 31:3 form the 8 byte aligned offset where bits 2:0 are
-zero.
+zero::
 
         +----------------------------+
         |31     Number of DFLS      0|
-- 
2.29.2

