Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CC6A23BDFC
	for <lists+linux-fpga@lfdr.de>; Tue,  4 Aug 2020 18:20:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729510AbgHDQUb (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 4 Aug 2020 12:20:31 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:39091 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727101AbgHDQU1 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 4 Aug 2020 12:20:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596558025;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=39irOBPTe9Z0kK4c/lNul+h0tOKXYZQuoF/1ateEpJQ=;
        b=SY+S0LMyti9W1bPkXsnQd93HVjteqaMimIGEjxFNwiImQ2TYC/twu/+cvxQdk6VwuctnfY
        d8ke8wjT8CfdNDigk76FV56BCOPfRD+foz0WCLUHD1wtiDf2vZ4KmR+fhyBo6skvAr9UZk
        fn6Re2lKNnT7Am8EFnQbgPez1ACv0F0=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-245-haskusoIMx-sR_FvFle2ZQ-1; Tue, 04 Aug 2020 12:20:20 -0400
X-MC-Unique: haskusoIMx-sR_FvFle2ZQ-1
Received: by mail-qk1-f199.google.com with SMTP id n128so28473097qke.2
        for <linux-fpga@vger.kernel.org>; Tue, 04 Aug 2020 09:20:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=39irOBPTe9Z0kK4c/lNul+h0tOKXYZQuoF/1ateEpJQ=;
        b=uJUL3d2EGr/zfXUGbjg8L84bhOLlxttugcun5oF8Ptn26urVoJSvHJLCYhEdH/CP9R
         U15vmyobCzrIgtfarTEQ5A6KVFFo+BHNNfWmLSfHTk0BnC0I1bCqqt2mdyQB4YNP3gIh
         rs/vrcFuAjW5jFYj5SAV/EJDEdX9VZSWx1F1SER9OfPJB7vx9+Dct95m+ujPgYp5KKWE
         PJt3pBfGGT24k3cufwmkFpTVyWooeP2t1Dy9PSs5NmTJdtK5pPwKvPyQY8b+Kuc3C0J/
         VDIR3AC6TejwH+yxA6FDkcR5U9kO//FWLEPV/EK4BfFcH7JOjh4gBD5enBjUYzfsLd+D
         QXUw==
X-Gm-Message-State: AOAM532OUvSpNI5DBkj5GElscHuHISqPwigz7Y1jFNDOgOAlBVfCMyMo
        RV9aH7+PWc1xE0UEWMTol4OAdqhs60PUing6HSBxW5mXGpARMpeqgzg70LDTH0oK2zfHfNYr36y
        wq7gCq2cc0vjBO5IO/JGe3Q==
X-Received: by 2002:a37:7245:: with SMTP id n66mr10663970qkc.83.1596558019627;
        Tue, 04 Aug 2020 09:20:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxB2lI38hkDboBDEtEVKpNlRUIDwbzgotiwqvt2H3cRPNRNgNz0BxpvsW5JbymjJ6lMBaoT3g==
X-Received: by 2002:a37:7245:: with SMTP id n66mr10663944qkc.83.1596558019290;
        Tue, 04 Aug 2020 09:20:19 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id q4sm21922585qkm.78.2020.08.04.09.20.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2020 09:20:18 -0700 (PDT)
From:   trix@redhat.com
To:     hao.wu@intel.com, mdf@kernel.org
Cc:     linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] MAINTAINERS: Add Tom Rix as fpga reviewer
Date:   Tue,  4 Aug 2020 09:20:03 -0700
Message-Id: <20200804162003.19402-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Tom Rix <trix@redhat.com>

I take care of fpga kernel and userspace for Red Hat and would
like help out more with the mainline kernel.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index ce2737b1feb5..6fdb01776413 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6805,6 +6805,7 @@ F:	drivers/net/ethernet/nvidia/*
 
 FPGA DFL DRIVERS
 M:	Wu Hao <hao.wu@intel.com>
+R:	Tom Rix <trix@redhat.com>
 L:	linux-fpga@vger.kernel.org
 S:	Maintained
 F:	Documentation/fpga/dfl.rst
@@ -6813,6 +6814,7 @@ F:	include/uapi/linux/fpga-dfl.h
 
 FPGA MANAGER FRAMEWORK
 M:	Moritz Fischer <mdf@kernel.org>
+R:	Tom Rix <trix@redhat.com>
 L:	linux-fpga@vger.kernel.org
 S:	Maintained
 W:	http://www.rocketboards.org
-- 
2.18.1

