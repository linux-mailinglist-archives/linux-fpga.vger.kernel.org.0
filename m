Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5503E75604
	for <lists+linux-fpga@lfdr.de>; Thu, 25 Jul 2019 19:46:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728553AbfGYRqM (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 25 Jul 2019 13:46:12 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34560 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726343AbfGYRqM (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 25 Jul 2019 13:46:12 -0400
Received: by mail-pf1-f196.google.com with SMTP id b13so23121081pfo.1
        for <linux-fpga@vger.kernel.org>; Thu, 25 Jul 2019 10:46:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KIEUujZBBpPF2FsXK/3C/Ifc337XmCaBCcdUOmfolVM=;
        b=NwCDCRyUWQslPsbFTPgQeJNLOpS5dcv90Z436mktfbAAfeTuxGXYHhKC3PsLQYA3Yg
         dXzDO5Pw4UQtyAqY2MBAfetmnaf5p7mKdERW6tLXmjtYEYqU2KqnAMy++aktm96EfXws
         PfaP5ipVEQ5oaT9qR9VYsxcxMYoJIydJHRWUbviukoGgm+TvemPn2vXCKJJzgj8r4VYt
         dkL97Ms7qQ3J9vXpKxdeX5mzT9RzndQq2mP5Q2PdFyLWnnsUg0PgF6AlDfxySgBq3rVx
         JeVdgFVi0xU6fjDn/GsuOKXNRxvlAYIoRYBBueUQDKxX/eH3bUo0Ebs5M5Bt1aGBpyM0
         voVQ==
X-Gm-Message-State: APjAAAUibBf+2OIwn1WKrmxItBZBKk4ndHsN8IF46t/OScKbQxTnP+dS
        cVH75Wn0U6Cf1RKkx/9/VNJ/MQ==
X-Google-Smtp-Source: APXvYqwSgDnD1dC3KbPIQcEuvMPLs/vPwaApQYOvM2klOHt+mpbLAUeYmQKwYs6mjiWOn6eosqC/ZA==
X-Received: by 2002:a17:90a:380d:: with SMTP id w13mr92156981pjb.138.1564076771845;
        Thu, 25 Jul 2019 10:46:11 -0700 (PDT)
Received: from localhost ([2601:647:5b80:29f7:1bdd:d748:9a4e:8083])
        by smtp.gmail.com with ESMTPSA id 67sm9996001pfd.177.2019.07.25.10.46.10
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 25 Jul 2019 10:46:10 -0700 (PDT)
From:   Moritz Fischer <mdf@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-fpga@vger.kernel.org, gregkh@linuxfoundation.org,
        Moritz Fischer <mdf@kernel.org>
Subject: [PATCH] MAINTAINERS: Move linux-fpga tree to new location
Date:   Thu, 25 Jul 2019 10:45:17 -0700
Message-Id: <20190725174517.10516-1-mdf@kernel.org>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Move the linux-fpga tree to new location at:
 git://git.kernel.org/pub/scm/linux/kernel/git/mdf/linux-fpga.git

Signed-off-by: Moritz Fischer <mdf@kernel.org>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 783569e3c4b4..c3b5e3dbc74e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6339,7 +6339,7 @@ FPGA MANAGER FRAMEWORK
 M:	Moritz Fischer <mdf@kernel.org>
 L:	linux-fpga@vger.kernel.org
 S:	Maintained
-T:	git git://git.kernel.org/pub/scm/linux/kernel/git/atull/linux-fpga.git
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/mdf/linux-fpga.git
 Q:	http://patchwork.kernel.org/project/linux-fpga/list/
 F:	Documentation/fpga/
 F:	Documentation/driver-api/fpga/
-- 
2.22.0

