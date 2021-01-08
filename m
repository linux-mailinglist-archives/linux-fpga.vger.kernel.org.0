Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EE332EFBE1
	for <lists+linux-fpga@lfdr.de>; Sat,  9 Jan 2021 00:55:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725775AbhAHXzM (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 8 Jan 2021 18:55:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725306AbhAHXzM (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 8 Jan 2021 18:55:12 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5F65C061573;
        Fri,  8 Jan 2021 15:54:31 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id u25so6223776lfc.2;
        Fri, 08 Jan 2021 15:54:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RKx8kUKUP9gXgJeIqsNauIlg2svK4cle8BTuxaul1L4=;
        b=j3+J4bsxBMa6mvcascbCMtsK0BGll+Uy2kTy/nx1rhFsdKx9PUCGZduReTqRrpNWEM
         YmiyhXX3uKBE73a2ndFA2XdHOTGt7fvL7zAA2g8fwnBRFy019OVXJtSSe9QXoviwxc/i
         OLvs2hkQ6BZlOguANf/AsNdEtD4yx5OgUtfNKQ4+GUgcEUxNaftEp7P0t3gr3LkmZjXo
         2pHvHjAEYYVSWm62m70bZNORb372sRjx1dYCtOByGABf5Ghx6C+RQKAtmOQrUOjwIcnq
         Pgnh28B9yOtCgCWpktjn868VJf3s2NWNIvioyzu8B/M+bp3XXFdksli/tLZzyeN7r7nM
         kLDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RKx8kUKUP9gXgJeIqsNauIlg2svK4cle8BTuxaul1L4=;
        b=jgm68rm40HBWGStq/5Hj8AsckIazUxgD4EoX2j6Hx2h6VBrTz8FifMv68gxPYFUkud
         l133UZ2l7t5V4r6zUKuHBqRzwwrivndc145DCMiQHAfz+Xr7mDo3ekTIfuQurHRUjDCL
         QC8LxzRcvu0eh2uXp742S+AyInJNlvyob/liFHyxWgxve0OpW3vVtyoimfKRoKDeQ+/P
         7jgSW+bQXiS45S6N2zBk1rtKaXL8Ds0IBuDyY5STMWKRZqNaaHgmxZSduI3uERFcv8Nx
         bNIllNdTGAJs4G0Tb2JZGTpomX0Lkg897ZrgqR/BpbHKYSJ+uDGiKNHn5Q2Wmst6fa77
         6izw==
X-Gm-Message-State: AOAM533qGMfntdl2DKfyxOKq6C61vuA6rJpfKWup7tCXnG91fc6Q1a9C
        WyIm0LEvm7E6SdCwCqVDN0g=
X-Google-Smtp-Source: ABdhPJw/S/J4uMe65N85xENgKJoazdDz+2GutARLCI58dizOqBHHTyfZSGvejTMPM7BTmiNwLhx9Gw==
X-Received: by 2002:a05:651c:2045:: with SMTP id t5mr2367084ljo.462.1610150070383;
        Fri, 08 Jan 2021 15:54:30 -0800 (PST)
Received: from localhost.localdomain (h-98-128-228-148.NA.cust.bahnhof.se. [98.128.228.148])
        by smtp.gmail.com with ESMTPSA id c5sm2233743lfh.160.2021.01.08.15.54.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jan 2021 15:54:29 -0800 (PST)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     Wu Hao <hao.wu@intel.com>, Tom Rix <trix@redhat.com>,
        Moritz Fischer <mdf@kernel.org>
Cc:     linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>
Subject: [PATCH] fpga: dfl: fme: Constify static attribute_group structs
Date:   Sat,  9 Jan 2021 00:54:14 +0100
Message-Id: <20210108235414.48017-1-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

The only usage of these is to put their addresses in arrays of pointers
to const attribute_groups. Make them const to allow the compiler to put
them in read-only memory.

Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
 drivers/fpga/dfl-fme-perf.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/fpga/dfl-fme-perf.c b/drivers/fpga/dfl-fme-perf.c
index 531266287eee..4299145ef347 100644
--- a/drivers/fpga/dfl-fme-perf.c
+++ b/drivers/fpga/dfl-fme-perf.c
@@ -192,7 +192,7 @@ static struct attribute *fme_perf_cpumask_attrs[] = {
 	NULL,
 };
 
-static struct attribute_group fme_perf_cpumask_group = {
+static const struct attribute_group fme_perf_cpumask_group = {
 	.attrs = fme_perf_cpumask_attrs,
 };
 
@@ -225,7 +225,7 @@ static struct attribute *fme_perf_format_attrs[] = {
 	NULL,
 };
 
-static struct attribute_group fme_perf_format_group = {
+static const struct attribute_group fme_perf_format_group = {
 	.name = "format",
 	.attrs = fme_perf_format_attrs,
 };
@@ -239,7 +239,7 @@ static struct attribute *fme_perf_events_attrs_empty[] = {
 	NULL,
 };
 
-static struct attribute_group fme_perf_events_group = {
+static const struct attribute_group fme_perf_events_group = {
 	.name = "events",
 	.attrs = fme_perf_events_attrs_empty,
 };
-- 
2.30.0

