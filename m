Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57E9A284D02
	for <lists+linux-fpga@lfdr.de>; Tue,  6 Oct 2020 16:05:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725939AbgJFOFL (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 6 Oct 2020 10:05:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:33532 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726536AbgJFOD4 (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 6 Oct 2020 10:03:56 -0400
Received: from mail.kernel.org (ip5f5ad5bd.dynamic.kabel-deutschland.de [95.90.213.189])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1048F208FE;
        Tue,  6 Oct 2020 14:03:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601993036;
        bh=i1ehfJ5a+ArhUT+7IpeOP77r+VemFZ1XPuELZc8RizM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GbK6BxyeQIeAqD4ut5Cmfa04waJ9DVyqRpsYzVb9nWxb1wPc1jcYk5MmUc9eIXSjD
         t+Zmjb3PMhCCdDZsB44Yqj4yxSqTgYKjCluYCSXukebFi4DmjDWIOz3GXQFE+HJIgC
         MFG09PpHYw4Tjss+5smPSQ4clv5oyYaw2my4vPwk=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kPnZI-0019GK-MY; Tue, 06 Oct 2020 16:03:52 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Moritz Fischer <mdf@kernel.org>, Tom Rix <trix@redhat.com>,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 40/52] docs: fpga: replace :c:member: macros
Date:   Tue,  6 Oct 2020 16:03:37 +0200
Message-Id: <89beed7f70ae8ae388fe25b004bd1afd4dccc425.1601992016.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1601992016.git.mchehab+huawei@kernel.org>
References: <cover.1601992016.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Those macros are not doing the right thing with Sphinx 3,
causing parse errors:

	./Documentation/driver-api/fpga/fpga-mgr.rst:104: WARNING: Unparseable C cross-reference: 'fpga_manager->state'
	Invalid C declaration: Expected end of definition. [error at 12]
	  fpga_manager->state
	  ------------^
	./Documentation/driver-api/fpga/fpga-programming.rst:18: WARNING: Unparseable C cross-reference: 'fpga_region->info'
	Invalid C declaration: Expected end of definition. [error at 11]
	  fpga_region->info
	  -----------^
	./Documentation/driver-api/fpga/fpga-region.rst:62: WARNING: Unparseable C cross-reference: 'fpga_region->bridge_list'
	Invalid C declaration: Expected end of definition. [error at 11]
	  fpga_region->bridge_list
	  -----------^
	./Documentation/driver-api/fpga/fpga-region.rst:62: WARNING: Unparseable C cross-reference: 'fpga_region->get_bridges'
	Invalid C declaration: Expected end of definition. [error at 11]
	  fpga_region->get_bridges
	  -----------^

Replace them by :c:expr:, with does what's desired.

Reviewed-by: Moritz Fischer <mdf@kernel.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/driver-api/fpga/fpga-mgr.rst         | 2 +-
 Documentation/driver-api/fpga/fpga-programming.rst | 2 +-
 Documentation/driver-api/fpga/fpga-region.rst      | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/driver-api/fpga/fpga-mgr.rst b/Documentation/driver-api/fpga/fpga-mgr.rst
index 22f7885b32c9..917ee22db429 100644
--- a/Documentation/driver-api/fpga/fpga-mgr.rst
+++ b/Documentation/driver-api/fpga/fpga-mgr.rst
@@ -101,7 +101,7 @@ in state.
 API for implementing a new FPGA Manager driver
 ----------------------------------------------
 
-* ``fpga_mgr_states`` —  Values for :c:member:`fpga_manager->state`.
+* ``fpga_mgr_states`` —  Values for :c:expr:`fpga_manager->state`.
 * struct fpga_manager —  the FPGA manager struct
 * struct fpga_manager_ops —  Low level FPGA manager driver ops
 * devm_fpga_mgr_create() —  Allocate and init a manager struct
diff --git a/Documentation/driver-api/fpga/fpga-programming.rst b/Documentation/driver-api/fpga/fpga-programming.rst
index f487ad64dfb9..002392dab04f 100644
--- a/Documentation/driver-api/fpga/fpga-programming.rst
+++ b/Documentation/driver-api/fpga/fpga-programming.rst
@@ -15,7 +15,7 @@ the FPGA manager and bridges.  It will:
  * lock the mutex of the region's FPGA manager
  * build a list of FPGA bridges if a method has been specified to do so
  * disable the bridges
- * program the FPGA using info passed in :c:member:`fpga_region->info`.
+ * program the FPGA using info passed in :c:expr:`fpga_region->info`.
  * re-enable the bridges
  * release the locks
 
diff --git a/Documentation/driver-api/fpga/fpga-region.rst b/Documentation/driver-api/fpga/fpga-region.rst
index 3e52be7e2968..363a8171ab0a 100644
--- a/Documentation/driver-api/fpga/fpga-region.rst
+++ b/Documentation/driver-api/fpga/fpga-region.rst
@@ -61,9 +61,9 @@ during the region's probe function.
 
 The FPGA region will need to specify which bridges to control while programming
 the FPGA.  The region driver can build a list of bridges during probe time
-(:c:member:`fpga_region->bridge_list`) or it can have a function that creates
+(:c:expr:`fpga_region->bridge_list`) or it can have a function that creates
 the list of bridges to program just before programming
-(:c:member:`fpga_region->get_bridges`).  The FPGA bridge framework supplies the
+(:c:expr:`fpga_region->get_bridges`).  The FPGA bridge framework supplies the
 following APIs to handle building or tearing down that list.
 
 * fpga_bridge_get_to_list() — Get a ref of an FPGA bridge, add it to a
-- 
2.26.2

