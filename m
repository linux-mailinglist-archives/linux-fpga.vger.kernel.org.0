Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6F7B28CD7F
	for <lists+linux-fpga@lfdr.de>; Tue, 13 Oct 2020 14:00:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728410AbgJMMAV (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 13 Oct 2020 08:00:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:58150 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727474AbgJMLyn (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 13 Oct 2020 07:54:43 -0400
Received: from mail.kernel.org (ip5f5ad5b2.dynamic.kabel-deutschland.de [95.90.213.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CB6C2223BD;
        Tue, 13 Oct 2020 11:54:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602590081;
        bh=i1ehfJ5a+ArhUT+7IpeOP77r+VemFZ1XPuELZc8RizM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=O7AGre3eWrnkcM4mXQibvxErJanrmuHiCacF82DcZQ1YwgeVh2Vs99iCx6eqlPQ7l
         bTg2TeQbiUlPDNz2DFO6iR186eJTFjSX4VTzP6bzhkhay5EnGtECzHgR4OsAUrcJZY
         XfGR4X5xk20cZ7V8mctuKAcc9jFr1CenMlwnGA3k=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kSIt4-006CV1-QN; Tue, 13 Oct 2020 13:54:38 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Moritz Fischer <mdf@kernel.org>, Tom Rix <trix@redhat.com>,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 40/80] docs: fpga: replace :c:member: macros
Date:   Tue, 13 Oct 2020 13:53:55 +0200
Message-Id: <bc213cf5197fc2d7f0c8e5f331189991536222be.1602589096.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1602589096.git.mchehab+huawei@kernel.org>
References: <cover.1602589096.git.mchehab+huawei@kernel.org>
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

