Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A61B300D00
	for <lists+linux-fpga@lfdr.de>; Fri, 22 Jan 2021 20:57:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728392AbhAVT4K (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 22 Jan 2021 14:56:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:42788 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730685AbhAVTbE (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Fri, 22 Jan 2021 14:31:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611343777;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=VYJ78Ar1mzsFJHybVSU5n5tY2j2fHeve7WHZtdWI4m4=;
        b=ZFeN2gIMsLemfmjfKA5KZMRC0i4tTo2YGzbwz//2WdpYA7nIrE8o/wd0Dbjf4ClS7eLVXf
        FNZC9FqmZ72igCxvc0YKfyk9DlpUAiQioAFiFrYEr1xl4H1JvsR0VI3gk1isvxL1WCkiRO
        jTX31gsOS9QqWkdct/W5qzX8KP2BjoU=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-60-aAtZZ2I2MjmO3FvyPb_NCA-1; Fri, 22 Jan 2021 14:29:35 -0500
X-MC-Unique: aAtZZ2I2MjmO3FvyPb_NCA-1
Received: by mail-qt1-f197.google.com with SMTP id j14so4353926qtv.3
        for <linux-fpga@vger.kernel.org>; Fri, 22 Jan 2021 11:29:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VYJ78Ar1mzsFJHybVSU5n5tY2j2fHeve7WHZtdWI4m4=;
        b=nmWRHStM/cIUBwZRZvvR1BT3TJNOIssJ7JoHgymJLskOIG+1EppKkfX9KmSA+rqyPo
         bzi6+yfHNksbi9bheepsfHnx+UIXDud+5LrARDPfQ/55JaqH3Y0QixIS+TyKZjdIwsR6
         rK34El8dCWsecyBuRwbh1tk+PZBTqfw0rnPUlQCNEAr/A8D6M8+gojajFsExT4KmBB41
         e0AG1gLIp4Y1BQqnBkrkxLpDN6f1Ayq/mwY8p0HD18f/aZlxvz7Fpf2Ixs2lnZVt9FIj
         gCw/+PT09oYKOtHKnqSbruJePfVFWHWzZXVgX7AfVXimkGqjtFLoc+HMz7gJb4cGjwu0
         RY4w==
X-Gm-Message-State: AOAM531lcAcr859jpqxw++o76AEJvMQqqWR7sWKJvJHEQtlAimOJq5gN
        IQsZpCfRNOQUoEiTYefFVDdUAqoXNxtfglnZGIYNdfz3vnFmpkf37QSQ+E5igzPM/oID6bR6Cqs
        YEnVJfIedXIFjqdSJWAIu1g==
X-Received: by 2002:a37:8b81:: with SMTP id n123mr6493701qkd.242.1611343774773;
        Fri, 22 Jan 2021 11:29:34 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzesA+Kn7fWetsbSppqsEkSvrsoEbmvS7Rr84cx4Z/4Ks7tdbBEqMeu8jlHeghWKd2//o1SWw==
X-Received: by 2002:a37:8b81:: with SMTP id n123mr6493685qkd.242.1611343774564;
        Fri, 22 Jan 2021 11:29:34 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id h125sm6939468qke.49.2021.01.22.11.29.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jan 2021 11:29:33 -0800 (PST)
From:   trix@redhat.com
To:     linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org
Cc:     Tom Rix <trix@redhat.com>
Subject: [PATCH v2] MAINTAINERS: Add FPGA SUBDEVICES
Date:   Fri, 22 Jan 2021 11:29:28 -0800
Message-Id: <20210122192928.1651254-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Tom Rix <trix@redhat.com>

Every FPGA has several subdevices in other subsystems.
The new FPGA subdevices section is necessary to ensure changes to
the subdevices files get reviewed within the context of the FPGA
subsystem.

Signed-off-by: Tom Rix <trix@redhat.com>
---
v1: Add several more subdevices
---
 MAINTAINERS | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 17ac5bdce521..96d6f00b0584 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6975,6 +6975,17 @@ F:	drivers/fpga/
 F:	include/linux/fpga/
 F:	tools/testing/selftests/drivers/fpga/
 
+FPGA SUBDEVICES
+R:	Tom Rix <trix@redhat.com>
+L:	linux-fpga@vger.kernel.org
+S:	Maintained
+F:	Documentation/ABI/testing/sysfs-driver-intel-m10-bmc
+F:	Documentation/hwmon/intel-m10-bmc-hwmon.rst
+F:	drivers/hwmon/intel-m10-bmc-hwmon.c
+F:	drivers/memory/dfl-emif.c
+F:	drivers/mfd/intel-m10-bmc.c
+F:	include/linux/mfd/intel-m10-bmc.h
+
 FPU EMULATOR
 M:	Bill Metzenthen <billm@melbpc.org.au>
 S:	Maintained
-- 
2.27.0

