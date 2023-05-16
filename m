Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8CC0704231
	for <lists+linux-fpga@lfdr.de>; Tue, 16 May 2023 02:17:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243228AbjEPAP0 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 15 May 2023 20:15:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244409AbjEPAPZ (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 15 May 2023 20:15:25 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFDC183CC;
        Mon, 15 May 2023 17:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=Hp8eNJ4FGKpWjH7/UXa5lxTHZ0gnhe4kAwB7/wEPm3k=; b=21bRxEKjid143LSrPJ9KQJmOHT
        TtiIYJjliwAW+K4n9rjMulnnBtYWP/OuxipzIldGbEkdezOK5fDLTOu+FHpF/2dO9QrWhR3DW5yBT
        0OR6ek7mZwtgChabZAnl2oyMmHOxF05TSKvuAe6VyHfAXNK2PV21MZ9uxu8kxIRN1ZsQSKqBbYS3k
        BDJB0l5jAMYDxd+TL2gXb9ipIAm+2ekYSySC24Y0wO3ziqbev7jXdsstoaHwkgPf8mME6e/XF0o4l
        I+wULKdlTZ64Jds88Ww2/JL+zuW8paR2xCrybFwUkyBK6ZE2TjyZtPu6T5Hpt6uWVXR6iWJLPEaZK
        3zQ7qn3w==;
Received: from [2601:1c2:980:9ec0::2764] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pyiLX-003vHf-1b;
        Tue, 16 May 2023 00:15:19 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-fpga@vger.kernel.org, Phillip Potter <phil@philpotter.co.uk>,
        Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH] Documentation: use capitalization for chapters and acronyms
Date:   Mon, 15 May 2023 17:15:18 -0700
Message-Id: <20230516001518.14514-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Use capital letters in acronyms for CD-ROM, FPGA, and PCMCIA.

Use capital letter in the first word of chapter headings for
Locking, Timers, and "Brief tutorial on CRC computation".

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
Cc: linux-fpga@vger.kernel.org
Cc: Phillip Potter <phil@philpotter.co.uk>
Cc: Moritz Fischer <mdf@kernel.org>
Cc: Wu Hao <hao.wu@intel.com>
Cc: Xu Yilun <yilun.xu@intel.com>
Cc: Tom Rix <trix@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Will Deacon <will@kernel.org>
Cc: Waiman Long <longman@redhat.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: Thomas Gleixner <tglx@linutronix.de>
---
 Documentation/cdrom/index.rst   |    6 +++---
 Documentation/fpga/index.rst    |    2 +-
 Documentation/locking/index.rst |    2 +-
 Documentation/pcmcia/index.rst  |    2 +-
 Documentation/staging/crc32.rst |    2 +-
 Documentation/timers/index.rst  |    2 +-
 6 files changed, 8 insertions(+), 8 deletions(-)

--- linux-next-20230515.orig/Documentation/cdrom/index.rst
+++ linux-next-20230515/Documentation/cdrom/index.rst
@@ -1,8 +1,8 @@
 .. SPDX-License-Identifier: GPL-2.0
 
-=====
-cdrom
-=====
+======
+CD-ROM
+======
 
 .. toctree::
     :maxdepth: 1
--- linux-next-20230515.orig/Documentation/fpga/index.rst
+++ linux-next-20230515/Documentation/fpga/index.rst
@@ -1,7 +1,7 @@
 .. SPDX-License-Identifier: GPL-2.0
 
 ====
-fpga
+FPGA
 ====
 
 .. toctree::
--- linux-next-20230515.orig/Documentation/locking/index.rst
+++ linux-next-20230515/Documentation/locking/index.rst
@@ -1,7 +1,7 @@
 .. SPDX-License-Identifier: GPL-2.0
 
 =======
-locking
+Locking
 =======
 
 .. toctree::
--- linux-next-20230515.orig/Documentation/pcmcia/index.rst
+++ linux-next-20230515/Documentation/pcmcia/index.rst
@@ -1,7 +1,7 @@
 .. SPDX-License-Identifier: GPL-2.0
 
 ======
-pcmcia
+PCMCIA
 ======
 
 .. toctree::
--- linux-next-20230515.orig/Documentation/staging/crc32.rst
+++ linux-next-20230515/Documentation/staging/crc32.rst
@@ -1,5 +1,5 @@
 =================================
-brief tutorial on CRC computation
+Brief tutorial on CRC computation
 =================================
 
 A CRC is a long-division remainder.  You add the CRC to the message,
--- linux-next-20230515.orig/Documentation/timers/index.rst
+++ linux-next-20230515/Documentation/timers/index.rst
@@ -1,7 +1,7 @@
 .. SPDX-License-Identifier: GPL-2.0
 
 ======
-timers
+Timers
 ======
 
 .. toctree::
