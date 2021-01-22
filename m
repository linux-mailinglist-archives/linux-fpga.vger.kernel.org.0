Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FA4530077C
	for <lists+linux-fpga@lfdr.de>; Fri, 22 Jan 2021 16:39:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728697AbhAVPhg (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 22 Jan 2021 10:37:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:22602 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728647AbhAVPha (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Fri, 22 Jan 2021 10:37:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611329761;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=5OaetzA2X1k5MGEpKaxVndnYKGJLfNEC7k1ws4H5Z8k=;
        b=gt3s7DTvtqF6E09odglg1nUTqvVR05qiAD/d7lA/2tvcTO+8CshLI6g4FCFvpfQYjg8C81
        8JkOIyjLokTSkrOZX1Ree7QY7LSy8T9IaVrtrNDZxQbUciKpddzVubAYzSdWgoo2Swpl6I
        3XzsAQIp2oFKspoMNDciBNg3Qi+21Qg=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-466-3aIUxiKNNbSPuNqXybm3vw-1; Fri, 22 Jan 2021 10:35:59 -0500
X-MC-Unique: 3aIUxiKNNbSPuNqXybm3vw-1
Received: by mail-qt1-f200.google.com with SMTP id o20so997369qtx.22
        for <linux-fpga@vger.kernel.org>; Fri, 22 Jan 2021 07:35:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5OaetzA2X1k5MGEpKaxVndnYKGJLfNEC7k1ws4H5Z8k=;
        b=Tpo2vU9xupPoNZ1PiDY3weHtjhP3WlsQd1nl952ZmdVpkyiaoI+B4dTbP+P2pl5zB3
         8hFYk2RtAdiZjWgf4AXG9TYwTOEmzSWnPDayBxPD+G7YSqRryUrYtuM3WeiI3Rjz6dJ8
         4Z/gUCoIMh2X4oMSqVfPOLSDtjsMcgW9qJkRDxVzKqt4ZlCJkajw7erSiRvqRF+5KXGQ
         QNT4cBdlE3k+iAqES1XPQa0UNrV9QWZngYIvntlH9igwSBrFor03KdZW0wS12rd3XTyv
         T4iYcv7+TrLU+jUD8HU+c43Ej4G0u38iXd126d5uc1zXDGfv5bxrhIENDnt/ZH1pt4LN
         tIRA==
X-Gm-Message-State: AOAM533oQexGCO3G4N/kz4szP+HkNLf3mNly6IzCSV3Z9/TEDVhdUdbX
        Vwl/T0tku7gxfycavMR5H+iYIWYsXY+6A4NquYgiS5Y8BPb1o0xrclJD9zb65dJUzvDn7qShxFf
        7iY9A5aTLcAfwtY68WvavKw==
X-Received: by 2002:ac8:742:: with SMTP id k2mr1262081qth.46.1611329758837;
        Fri, 22 Jan 2021 07:35:58 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy++Z+hJclHXyI3osvFTQcObz6LvEA4A4Z9JXbk6AQZM6ZRtWQeFFTZvLsnyyLEFv/Dj5ZLfA==
X-Received: by 2002:ac8:742:: with SMTP id k2mr1262060qth.46.1611329758646;
        Fri, 22 Jan 2021 07:35:58 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id t51sm1309069qte.8.2021.01.22.07.35.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jan 2021 07:35:58 -0800 (PST)
From:   trix@redhat.com
To:     linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org
Cc:     Tom Rix <trix@redhat.com>
Subject: [PATCH] MAINTAINERS: Add FPGA SUBDEVICES
Date:   Fri, 22 Jan 2021 07:35:52 -0800
Message-Id: <20210122153552.1606152-1-trix@redhat.com>
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
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 17ac5bdce521..cdda41f182b9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6975,6 +6975,12 @@ F:	drivers/fpga/
 F:	include/linux/fpga/
 F:	tools/testing/selftests/drivers/fpga/
 
+FPGA SUBDEVICES
+R:	Tom Rix <trix@redhat.com>
+L:	linux-fpga@vger.kernel.org
+S:	Maintained
+F:	include/linux/mfd/intel-m10-bmc.*
+
 FPU EMULATOR
 M:	Bill Metzenthen <billm@melbpc.org.au>
 S:	Maintained
-- 
2.27.0

