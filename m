Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33ABD41B28D
	for <lists+linux-fpga@lfdr.de>; Tue, 28 Sep 2021 17:03:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241427AbhI1PEm (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 28 Sep 2021 11:04:42 -0400
Received: from mail-pf1-f178.google.com ([209.85.210.178]:42783 "EHLO
        mail-pf1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241392AbhI1PEm (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 28 Sep 2021 11:04:42 -0400
Received: by mail-pf1-f178.google.com with SMTP id q23so19133914pfs.9
        for <linux-fpga@vger.kernel.org>; Tue, 28 Sep 2021 08:03:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=T4midNwLhQRsV+18+8f15b0ax8Dt09P9qH8Sqhsix1I=;
        b=xhzrK1d+q8C3qonQgE4jdtYvyJ+ikQqdIENiuf8jLFX3rAiw1q1v/hivEE87qhKNri
         gvSWGpkdqtQqAvzSK2xvsuk+9L4/irvMpfZQBtcX/6ReC3Ga3Zo0xwY8UaPHN0hScn/Q
         Q8rbj6M1IiZqyHzk+/F2znoNrEMFV4aKaa7bYgYKAluxJWFPtHiwGoKzWsbCV93p5faB
         aQB6E4w658vs9fpmF9+ml40cmMVnU/+IfY0I0wF3w4JOAylR7UnRTPoHUKCd2cKtTVH4
         8FBDOtR9HfmUVn5nVl9dgNAhc4z1fVarUTHYBLFxUXuIfcInLc2NZqVejur7l7+A9G7h
         V9TA==
X-Gm-Message-State: AOAM531UlEOMwJ3EXE1O4sM4cpdebIqDM0uVp4HXA9aoo9AsxNjSXPfC
        SEd4KIpYjzLFOWpV1xLDI5g2fhQfcw0=
X-Google-Smtp-Source: ABdhPJwyPbuKNi2+aTZnommRzI9VHp/Llm06l0T19VPBCjcQr5BsP5CEADcBlBV18bR2Tg1rQNdg8w==
X-Received: by 2002:a63:7543:: with SMTP id f3mr4991215pgn.449.1632841382247;
        Tue, 28 Sep 2021 08:03:02 -0700 (PDT)
Received: from localhost ([2601:647:5b00:6f70:be34:681b:b1e9:776f])
        by smtp.gmail.com with ESMTPSA id s69sm22109680pgc.35.2021.09.28.08.02.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 08:02:58 -0700 (PDT)
From:   Moritz Fischer <mdf@kernel.org>
To:     linux-fpga@vger.kernel.org
Cc:     moritzf@google.com, Moritz Fischer <mdf@kernel.org>,
        Xu Yilun <yilun.xu@intel.com>, Wu Hao <hao.wu@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 1/2] MAINTAINERS: Add Hao and Yilun as maintainers
Date:   Tue, 28 Sep 2021 08:02:25 -0700
Message-Id: <20210928150227.22275-1-mdf@kernel.org>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hao and Yilun have agreed to help out with maintenance.
Both have been active in the Linux FPGA community for a long time
and we need backups for vacation and load-balancing.

Cc: Xu Yilun <yilun.xu@intel.com>
Cc: Wu Hao <hao.wu@intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Moritz Fischer <mdf@kernel.org>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index eeb4c70b3d5b..2ec4c2a2458a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7337,6 +7337,8 @@ F:	include/uapi/linux/fpga-dfl.h
 
 FPGA MANAGER FRAMEWORK
 M:	Moritz Fischer <mdf@kernel.org>
+M:	Wu Hao <hao.wu@intel.com>
+M:	Xu Yilun <yilun.xu@intel.com>
 R:	Tom Rix <trix@redhat.com>
 L:	linux-fpga@vger.kernel.org
 S:	Maintained
-- 
2.33.0

