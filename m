Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E912D41B28F
	for <lists+linux-fpga@lfdr.de>; Tue, 28 Sep 2021 17:03:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241503AbhI1PEr (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 28 Sep 2021 11:04:47 -0400
Received: from mail-pl1-f181.google.com ([209.85.214.181]:37434 "EHLO
        mail-pl1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241474AbhI1PEq (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 28 Sep 2021 11:04:46 -0400
Received: by mail-pl1-f181.google.com with SMTP id j14so14388688plx.4
        for <linux-fpga@vger.kernel.org>; Tue, 28 Sep 2021 08:03:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tot8ctnAdjD5hlKT5mz2bezp8eyxWpruLW03YpLNGiE=;
        b=XJlk13otSql6JGNEP3zzbwko8Bi/nzGT5/mSrBr35pDW43TaGHb05rPqzE1ruAs8Pm
         OfGHtETtyuBE4Xjx5yihRmP7R/ZKNLp/4T9adPapqlpppCNncdRo2+wyDw2xXsTvP6d4
         80fqRsKdeBgTBcmqOskkrdU+wg4KhBiW/bv86cg+LnxFuqSkOMdj/yJc3/IhxNC5u3/N
         QvcLUDDzvgq47hO2ZOnB05UDW/9RKI29VOiKq6WgG4nUhBrAGHLSat6FwGWyxqBhPJtE
         TT7Kx1/MgNqdDl/c6pwkkH37gkxtzmPhzsJUOQqBfYyGqktLzxMmMaFMONCWxA23n3Z/
         omBg==
X-Gm-Message-State: AOAM531PT8Heu4sLZ60omlmfdt1jNNpZimeWU9iiULzVAjnEwdKxJP0/
        XJq9/H8aYYlxwi2/v9/aV9/VL+SjHg4=
X-Google-Smtp-Source: ABdhPJwBy731JWAoY2w7602W+oaBozqf0TDs3eFylHca270rUwGxGydCly0Jv2DhwB8ZfYm0V/viEQ==
X-Received: by 2002:a17:90b:3143:: with SMTP id ip3mr501530pjb.50.1632841386298;
        Tue, 28 Sep 2021 08:03:06 -0700 (PDT)
Received: from localhost ([2601:647:5b00:6f70:be34:681b:b1e9:776f])
        by smtp.gmail.com with ESMTPSA id h2sm2772981pjk.44.2021.09.28.08.03.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 08:03:03 -0700 (PDT)
From:   Moritz Fischer <mdf@kernel.org>
To:     linux-fpga@vger.kernel.org
Cc:     moritzf@google.com, Moritz Fischer <mdf@kernel.org>,
        Xu Yilun <yilun.xu@intel.com>, Wu Hao <hao.wu@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 2/2] MAINTAINERS: Drop outdated FPGA Manager website
Date:   Tue, 28 Sep 2021 08:02:26 -0700
Message-Id: <20210928150227.22275-2-mdf@kernel.org>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210928150227.22275-1-mdf@kernel.org>
References: <20210928150227.22275-1-mdf@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

The rocketboards website no longer really reflects a good landing
place for people interested in FPGA Manager.

Cc: Xu Yilun <yilun.xu@intel.com>
Cc: Wu Hao <hao.wu@intel.com>
Signed-off-by: Moritz Fischer <mdf@kernel.org>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2ec4c2a2458a..c4eaac287edb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7342,7 +7342,6 @@ M:	Xu Yilun <yilun.xu@intel.com>
 R:	Tom Rix <trix@redhat.com>
 L:	linux-fpga@vger.kernel.org
 S:	Maintained
-W:	http://www.rocketboards.org
 Q:	http://patchwork.kernel.org/project/linux-fpga/list/
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/mdf/linux-fpga.git
 F:	Documentation/devicetree/bindings/fpga/
-- 
2.33.0

