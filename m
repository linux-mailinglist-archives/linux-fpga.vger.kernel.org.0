Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 905863A6CC8
	for <lists+linux-fpga@lfdr.de>; Mon, 14 Jun 2021 19:09:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235472AbhFNRL2 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 14 Jun 2021 13:11:28 -0400
Received: from mail-pj1-f41.google.com ([209.85.216.41]:40822 "EHLO
        mail-pj1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235470AbhFNRL1 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 14 Jun 2021 13:11:27 -0400
Received: by mail-pj1-f41.google.com with SMTP id mp5-20020a17090b1905b029016dd057935fso10482551pjb.5
        for <linux-fpga@vger.kernel.org>; Mon, 14 Jun 2021 10:09:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CfADbUiO5XrTDnFfW6staI5R+wFQK6+JiA4pAz+CoVg=;
        b=n7Zao27HbDWi3OwDOgg1ZtRVkegSOC7rTbP9OTdA1/xqp023CV4oFvWsu+bq2qZdoQ
         j28tZLga0RCsSTRxVf0lT3ILHjtqmtfJKcRUbTtZVmStPg9/tH5Lq+FgZFh1U1AwE2h+
         vszeyIuzkF8q3VDGYOXTOwkZTo7APdxMFGuR7EikLCT+eOoAKIupQ5q85xCYeLUEHrkl
         KRpLnosFnzVQf/zhFUZCyYy6cpiqptv94tKPk3DzF8l+l22ixoNBY03ZRn8v0/FIxGeY
         ReTIeWsgEXAXXUKmh9339mm/4tA8763viTDxfk7kDSfEeXf+J6K+aCPVaUzefydkjUkJ
         sH5w==
X-Gm-Message-State: AOAM53374bZw8vYnlPFLtiEbRG2V55nNzWMdC/lhQDR8RQkmWUStkwwO
        wjXr9trP5Y/Qx/COmLgPV0dGnNHA/Vq86Q==
X-Google-Smtp-Source: ABdhPJx70zpT59rCtOc5s+qlxLaTNo/1WRbAdk8GxPYXDoOObKVeTjNzPhjEC3y8FlUfx5xaC/dCvA==
X-Received: by 2002:a17:90b:1511:: with SMTP id le17mr19826685pjb.137.1623690564383;
        Mon, 14 Jun 2021 10:09:24 -0700 (PDT)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id j13sm13028037pgp.29.2021.06.14.10.09.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 10:09:23 -0700 (PDT)
From:   Moritz Fischer <mdf@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-fpga@vger.kernel.org, Moritz Fischer <mdf@kernel.org>,
        Russ Weight <russell.h.weight@intel.com>,
        Xu Yilun <yilun.xu@intel.com>
Subject: [PATCH 1/8] fpga: altera-pr-ip: Remove function alt_pr_unregister
Date:   Mon, 14 Jun 2021 10:09:02 -0700
Message-Id: <20210614170909.232415-2-mdf@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210614170909.232415-1-mdf@kernel.org>
References: <20210614170909.232415-1-mdf@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Russ Weight <russell.h.weight@intel.com>

Remove the alt_pr_unregister() function; it is no longer used.

Signed-off-by: Russ Weight <russell.h.weight@intel.com>
Reviewed-by: Xu Yilun <yilun.xu@intel.com>
Signed-off-by: Moritz Fischer <mdf@kernel.org>
---
 drivers/fpga/altera-pr-ip-core.c       | 10 ----------
 include/linux/fpga/altera-pr-ip-core.h |  1 -
 2 files changed, 11 deletions(-)

diff --git a/drivers/fpga/altera-pr-ip-core.c b/drivers/fpga/altera-pr-ip-core.c
index 5b130c4d9882..dfdf21ed34c4 100644
--- a/drivers/fpga/altera-pr-ip-core.c
+++ b/drivers/fpga/altera-pr-ip-core.c
@@ -199,16 +199,6 @@ int alt_pr_register(struct device *dev, void __iomem *reg_base)
 }
 EXPORT_SYMBOL_GPL(alt_pr_register);
 
-void alt_pr_unregister(struct device *dev)
-{
-	struct fpga_manager *mgr = dev_get_drvdata(dev);
-
-	dev_dbg(dev, "%s\n", __func__);
-
-	fpga_mgr_unregister(mgr);
-}
-EXPORT_SYMBOL_GPL(alt_pr_unregister);
-
 MODULE_AUTHOR("Matthew Gerlach <matthew.gerlach@linux.intel.com>");
 MODULE_DESCRIPTION("Altera Partial Reconfiguration IP Core");
 MODULE_LICENSE("GPL v2");
diff --git a/include/linux/fpga/altera-pr-ip-core.h b/include/linux/fpga/altera-pr-ip-core.h
index 0b08ac20ab16..a6b4c07858cc 100644
--- a/include/linux/fpga/altera-pr-ip-core.h
+++ b/include/linux/fpga/altera-pr-ip-core.h
@@ -13,6 +13,5 @@
 #include <linux/io.h>
 
 int alt_pr_register(struct device *dev, void __iomem *reg_base);
-void alt_pr_unregister(struct device *dev);
 
 #endif /* _ALT_PR_IP_CORE_H */
-- 
2.31.1

