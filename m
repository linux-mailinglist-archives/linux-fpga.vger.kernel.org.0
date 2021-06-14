Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9ABC63A6CCD
	for <lists+linux-fpga@lfdr.de>; Mon, 14 Jun 2021 19:09:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235503AbhFNRLp (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 14 Jun 2021 13:11:45 -0400
Received: from mail-pf1-f173.google.com ([209.85.210.173]:40929 "EHLO
        mail-pf1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235500AbhFNRLp (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 14 Jun 2021 13:11:45 -0400
Received: by mail-pf1-f173.google.com with SMTP id q25so11020340pfh.7
        for <linux-fpga@vger.kernel.org>; Mon, 14 Jun 2021 10:09:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MW9wowscZURk0RXBZlljpwSHr7tI2uW4NqHBQr/f+eY=;
        b=HCviIH2qZ66ARxiGBkBroLmCwRXP73/o5NJU6R182Xv8FMwIosD8FWrOCiuahu2bdG
         R1Sn+Mb9Qi3EURAbHakruwNx71yCRL0t5cq+TP30/cD3+hcbpvHGrvYOZUpl6fVcj74c
         jeReYwc+QAc34gBkkHsq0SRyfCXgeUYWH17mucY0RCBXISHPXV5b6oYxFk0ONdjSwZve
         dSDefjO9ZxkOJjqo5P4lrgJRSzTLrrlolw0pGdCOe8ksTzdNOpDCt/XvK49whqDWKuIR
         KuYO28wAHSxzlKNtDjBhjlMkphK1NdFKFFIC5qqpDcO/oMGClLC7Z1ZT9xvCHSacg5Z1
         Q9yg==
X-Gm-Message-State: AOAM531qAAgVMXx5M15M+nRgj4UV59hHcU/tKCJTdYL+0M6DNPjR671f
        KIuYxEBopByqJ3ot6Va87Hfj08gAcHKUIg==
X-Google-Smtp-Source: ABdhPJycDGFaPTlJy4xXQmheh272MoYAFG4fipc0hJbt2jLpAQ3Yy5ObVhJDEsNotP0B7k8tFcDCYg==
X-Received: by 2002:a63:6841:: with SMTP id d62mr18078444pgc.7.1623690565896;
        Mon, 14 Jun 2021 10:09:25 -0700 (PDT)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id v67sm13132820pfb.193.2021.06.14.10.09.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 10:09:25 -0700 (PDT)
From:   Moritz Fischer <mdf@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-fpga@vger.kernel.org, Moritz Fischer <mdf@kernel.org>,
        Russ Weight <russell.h.weight@intel.com>,
        Xu Yilun <yilun.xu@intel.com>
Subject: [PATCH 2/8] fpga: stratix10-soc: Add missing fpga_mgr_free() call
Date:   Mon, 14 Jun 2021 10:09:03 -0700
Message-Id: <20210614170909.232415-3-mdf@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210614170909.232415-1-mdf@kernel.org>
References: <20210614170909.232415-1-mdf@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Russ Weight <russell.h.weight@intel.com>

The stratix10-soc driver uses fpga_mgr_create() function and is therefore
responsible to call fpga_mgr_free() to release the class driver resources.
Add a missing call to fpga_mgr_free in the s10_remove() function.

Signed-off-by: Russ Weight <russell.h.weight@intel.com>
Reviewed-by: Xu Yilun <yilun.xu@intel.com>
Signed-off-by: Moritz Fischer <mdf@kernel.org>
---
 drivers/fpga/stratix10-soc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/fpga/stratix10-soc.c b/drivers/fpga/stratix10-soc.c
index 657a70c5fc99..9e34bbbce26e 100644
--- a/drivers/fpga/stratix10-soc.c
+++ b/drivers/fpga/stratix10-soc.c
@@ -454,6 +454,7 @@ static int s10_remove(struct platform_device *pdev)
 	struct s10_priv *priv = mgr->priv;
 
 	fpga_mgr_unregister(mgr);
+	fpga_mgr_free(mgr);
 	stratix10_svc_free_channel(priv->chan);
 
 	return 0;
-- 
2.31.1

