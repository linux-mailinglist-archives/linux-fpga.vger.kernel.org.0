Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1B923A05BD
	for <lists+linux-fpga@lfdr.de>; Tue,  8 Jun 2021 23:24:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234250AbhFHV0I (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 8 Jun 2021 17:26:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23648 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234265AbhFHV0E (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 8 Jun 2021 17:26:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623187451;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=V9tvOeij7irPdqtg/4eaarQWu4Ala2EOw38yDUGQMKE=;
        b=RLc+JhQaq9yO+Ymi8CEoEJGmtNgyCaJS1uQg3PAhQRXyF47JF/YT3VUFvMq0oGpvnjJuRe
        7R/Ti2pZ7BcGWKc+se/bzpDk21RUk3IVxU/dBPF/Tt656kHzPh5cpd9yImz+vV5lqMtWtD
        TBk6w3hYMNokMoUjcuY44ZxW12a1FF8=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-557-cEG0y2OUNwmZk3lKlhL-EA-1; Tue, 08 Jun 2021 17:24:09 -0400
X-MC-Unique: cEG0y2OUNwmZk3lKlhL-EA-1
Received: by mail-oi1-f198.google.com with SMTP id f84-20020aca38570000b02901f424a672b7so3192126oia.18
        for <linux-fpga@vger.kernel.org>; Tue, 08 Jun 2021 14:24:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=V9tvOeij7irPdqtg/4eaarQWu4Ala2EOw38yDUGQMKE=;
        b=t61/jitUk0LxtdPGXp0b6O9uvDUm944Vyzw/owyCClmh1C9dauBuMSwWKVqFkYHU5S
         fmvqoU3d2e3M+zh743uAcLm6Ifz638V5vrJjG+wvSMNo1Ea+EOjWlUsR5/aa8nQWhi1/
         AVVQQO5AhgZrD6IG6shZ1lpenPQ57tNTzAGHNob2ffay7f6j5L4gjcNbLfaiNcRcRzIn
         riljh6GgigspSBYiUHPsFvrpkPgnV3z6vfFuIplwx3026m7Ei5pZ21bBtZIE8IUyT955
         6bHxOp+jFbJTVcjYzy9pYIwls2DqWv3UChzQGKtz2gJSuk0pYYDl1I7hkjwXKhtVepL9
         cUQg==
X-Gm-Message-State: AOAM532LSauzJFLzimg9syfE++PiSuyceeNvgdDcZO3qCOCuIyqsweUo
        G5pz8ANsKIoI0BV0RA5SNNHM0pfwq1Cu3BD6boocfkrN8D/bnmarV0Ao3uoblMWCa5wQLKJEwjF
        Y5jfku0tlKdfHLCKqntS1Dg==
X-Received: by 2002:a4a:ded3:: with SMTP id w19mr5293597oou.46.1623187449152;
        Tue, 08 Jun 2021 14:24:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxUcRpoqPmXEA6scCuFTxzSHKgG4PG3qjyFY5xu7aC63DD0rnFJZyVbbKXaRqPE6V2Ub7Lciw==
X-Received: by 2002:a4a:ded3:: with SMTP id w19mr5293585oou.46.1623187448949;
        Tue, 08 Jun 2021 14:24:08 -0700 (PDT)
Received: from localhost.localdomain.com (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id x199sm1954310oif.5.2021.06.08.14.24.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 14:24:08 -0700 (PDT)
From:   trix@redhat.com
To:     mdf@kernel.org, robh+dt@kernel.org, hao.wu@intel.com,
        corbet@lwn.net, fbarrat@linux.ibm.com, ajd@linux.ibm.com,
        bbrezillon@kernel.org, arno@natisbad.org, schalla@marvell.com,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        gregkh@linuxfoundation.org, Sven.Auhagen@voleatech.de,
        grandmaster@al2klimov.de
Cc:     linux-fpga@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-crypto@vger.kernel.org,
        linux-staging@lists.linux.dev, Tom Rix <trix@redhat.com>
Subject: [PATCH 03/11] Documentation: ocxl.rst: change FPGA indirect article to an
Date:   Tue,  8 Jun 2021 14:23:42 -0700
Message-Id: <20210608212350.3029742-5-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210608212350.3029742-1-trix@redhat.com>
References: <20210608212350.3029742-1-trix@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Tom Rix <trix@redhat.com>

Change use of 'a fpga' to 'an fpga'

Signed-off-by: Tom Rix <trix@redhat.com>
---
 Documentation/userspace-api/accelerators/ocxl.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/userspace-api/accelerators/ocxl.rst b/Documentation/userspace-api/accelerators/ocxl.rst
index 14cefc020e2d5..db7570d5e50d1 100644
--- a/Documentation/userspace-api/accelerators/ocxl.rst
+++ b/Documentation/userspace-api/accelerators/ocxl.rst
@@ -6,7 +6,7 @@ OpenCAPI is an interface between processors and accelerators. It aims
 at being low-latency and high-bandwidth. The specification is
 developed by the `OpenCAPI Consortium <http://opencapi.org/>`_.
 
-It allows an accelerator (which could be a FPGA, ASICs, ...) to access
+It allows an accelerator (which could be an FPGA, ASICs, ...) to access
 the host memory coherently, using virtual addresses. An OpenCAPI
 device can also host its own memory, that can be accessed from the
 host.
-- 
2.26.3

