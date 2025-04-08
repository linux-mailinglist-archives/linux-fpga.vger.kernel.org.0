Return-Path: <linux-fpga+bounces-1144-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88363A8163C
	for <lists+linux-fpga@lfdr.de>; Tue,  8 Apr 2025 22:01:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9DA6C7B5DFB
	for <lists+linux-fpga@lfdr.de>; Tue,  8 Apr 2025 20:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E7D81CEADB;
	Tue,  8 Apr 2025 20:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="ZSMIzKvd"
X-Original-To: linux-fpga@vger.kernel.org
Received: from CY4PR05CU001.outbound.protection.outlook.com (mail-westcentralusazolkn19010011.outbound.protection.outlook.com [52.103.7.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB72A157A72
	for <linux-fpga@vger.kernel.org>; Tue,  8 Apr 2025 20:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.7.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744142441; cv=fail; b=beHDzOB7xmIQf63Jcw/138Nj6JSGuLP2lsH7Ht2q1XQod7EUUqJn2DJedycDqDbj2fUdLniJPWuRGriFk2M1uHGnPkuj6xQ9lBjRSKWFEqtUeFh5YRw/JhC6hZztJaCUtjJfLl8Eig+ZNfBHVq0bHECxBFk7JyhNDNTo1iFbfdY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744142441; c=relaxed/simple;
	bh=pVQ6yw+xkNOL13ZrdKYmAuM1RfOeThnXORRcJ85ZtQ8=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=PZ6j+7FItyEaYI9EZKRzcNexVFmCZQmxJw/b02mqJwWxbPh+9nsOlbFIuziiV0emUFXqOQ+CccvM+xQaxwyXMw8lzi4ARkBLkYW3B8v9U49r6UhqYqhWGLKlvh70effXlMhsG7So5GvVQ8bYsAPlRpsOxfoH587KgN2WZTdDyY4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=ZSMIzKvd; arc=fail smtp.client-ip=52.103.7.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YpD1p5OhPXjobPcIErRrAbXMLBBoNn1bs3jqCkmqOnGLKKivClyCvzaFBFCb40JTcdK4nwSMeceIIitBkrzxP4esbJCPIRz12u7VIpKeNoDabm5UEPcD7oG18APKO/RC8c3OV6qyuLsD93JUU6JvuKchE46YI+1UO6Se8SpZsQIYhyb/U6yYNo6Uug5fd6AUtyL8QfYfTvEWD/THpe4POTcFU5C26R0LEpfjMNuOMvBJm3+loV7vKWQGQqrrJuf46t14J5jxOOCHZ4C/aVzHE6vSyZfUdmJFkQ2VNj2ESLLruLDB/4p7ak0RxwQpQQpaaIR/Zaz9CXoY9VmGbVLf/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pVQ6yw+xkNOL13ZrdKYmAuM1RfOeThnXORRcJ85ZtQ8=;
 b=q0DuNhN4h7FjwlO9y9flpPq2vx0A1JVhU3C05lgL/4kWizMBBkmy51JLdBsXLaGCiFfTtMN5810Tx+HlwKfOl0zLVzR+AfwNFvQs1KxVKfActunzzlE4GzLf3t3EA9aghV8ReK8XVAdzJr0VZqxq5jDoEbLsNfyw9gpHGO6dO49HiFdcEBhYEmvGNt1WdmOGpBz1xzUtzEPDavIEWQtfG9mOWS3AjCm+eg9huzHwnjIXZ3//Rp63c5aid47M7l67ntAGdjO1nxVW8WA8z8WUNpKT9IqFqL9rZfrp7kcszAOXNMsBinrMOTmu/IcZuCEnK0Mj3b/cmn6JNieE1JnaIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pVQ6yw+xkNOL13ZrdKYmAuM1RfOeThnXORRcJ85ZtQ8=;
 b=ZSMIzKvdrSnbweA74XZBS6EEja0SkcaCtR6QaNqBRKIR6H2X+QjHelFWqV07gQjiV9sbOvH5Q7XqJnW2bZb8er5LdY3eO69uYE762DaVk5tA1n1r+C1Bi9JzbyhMycylz0GlLDhXmClMGpPVJTm5zLJqZfieC38bz6/v/vdSlPXIKVXCKpMXr2/peEnbhZnYdAXNKb3W0KcEDj8DiEmdNHZ6rofbwfFNGTO/rK1GGLSRAOVHICWtyRU6IMppruRM2pg7iZUvtWwcTIXiCkBRN1iGw6A/GxUBdu3a3EwnW7JiXO2KAOu1JtIgI7PHI3RTnjVFcD8l7KXrkwmHtmYr+g==
Received: from PH0PR04MB7818.namprd04.prod.outlook.com (2603:10b6:510:ec::16)
 by CH2PR04MB6726.namprd04.prod.outlook.com (2603:10b6:610:95::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.33; Tue, 8 Apr
 2025 20:00:37 +0000
Received: from PH0PR04MB7818.namprd04.prod.outlook.com
 ([fe80::2e62:9013:9448:74ea]) by PH0PR04MB7818.namprd04.prod.outlook.com
 ([fe80::2e62:9013:9448:74ea%4]) with mapi id 15.20.8606.028; Tue, 8 Apr 2025
 20:00:37 +0000
From: Brenda Wilson <brenda.prospecttechconnect@outlook.com>
To: "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>
Subject: Unlock aerospace leads from MRO Americas 2025 attendee database
Thread-Topic: Unlock aerospace leads from MRO Americas 2025 attendee database
Thread-Index: AduojeDaeFWE3d5MQzS8h1vHoi1tOw==
Disposition-Notification-To: Brenda Wilson
	<brenda.prospecttechconnect@outlook.com>
Date: Tue, 8 Apr 2025 20:00:37 +0000
Message-ID:
 <PH0PR04MB781894F44FA3B0CA879DBE5794B52@PH0PR04MB7818.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7818:EE_|CH2PR04MB6726:EE_
x-ms-office365-filtering-correlation-id: 30daa9f9-bc94-49b3-7fdd-08dd76d80807
x-microsoft-antispam:
 BCL:0;ARA:14566002|8060799006|8062599003|461199028|19110799003|15080799006|3412199025|440099028|41001999003|102099032;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?c7kvFlG1bgO/oZ+e2Xtb6bw4eRzh0ZS4r2zeVxnG3goHx/ZCcY2M3gZvYn?=
 =?iso-8859-1?Q?dYNDHxc66T8dpVQsADCnIFOlRi1NMdYoVusNmgAa3m38runWqSJOESUV46?=
 =?iso-8859-1?Q?aPeYRrrpJcRWtfgL+TnMyBGSAyp3+Zk3C1VBPJk0MU/Y1SiavrYdS9UrU8?=
 =?iso-8859-1?Q?cYS2OQBSQdyJbR7Bp+4yhJ3017kWaS7MEIJFtSC9pY1R42D0g0ODY/Rk+X?=
 =?iso-8859-1?Q?uRAmtP5TZavtQ2pk85ity7tetMgX8V+nGzCjPCVUo7pN3cJvKizCoJxSxe?=
 =?iso-8859-1?Q?qv/flcqEzcMzDECQmdkHg/NU7JwuPfhDJ4IM1sTzwsw19IM4t5eLEJBACL?=
 =?iso-8859-1?Q?V9MVfc6clV6OGBh29bJgUb71eb5pbmWiyLL65qZYjcx/OQ0GBUaXzC8cVR?=
 =?iso-8859-1?Q?3jaxaMnBugVB6QHr7jImwmWywqWVrTeVQgx4cmw9mIdmS8/YQFmGUnbD0b?=
 =?iso-8859-1?Q?ksigaHfIscsb4OrorHZC2bnH3f/snxhbvz8zU29dEI2QBo1EZwx7mNPU1d?=
 =?iso-8859-1?Q?MAA14giTQtP7KQP3C/5Wyih8sUAhQEJ8j2Cb6wQ+A8SIhblVs3BW3qLIxr?=
 =?iso-8859-1?Q?h7B8k/Yg6U/Z0oAFkR922mXLl/tnG3P4+z/M6yW5+htQvYmKUMjaFBWeez?=
 =?iso-8859-1?Q?JcOTT9tgApXV6FEg0/foalajl+GNqDYJDyLpdUGXMb8Kcpvc4CV0o1UNWt?=
 =?iso-8859-1?Q?0uBn4kmq4d3mTlKO8MCKTo/3iNcejlKDlXtAlQmx3O+cysj54WQ3G7OmYf?=
 =?iso-8859-1?Q?9HO0fO9/yV+hiDDndheQJLt8/DO+nZEgIxrhNt8WLqF+NFfrv3olzcbXl+?=
 =?iso-8859-1?Q?jA5eE1e4nDyTf9hlgGTQpCahN9+rSBWnNw18Q3H5maQX31QcAcLTokaEh2?=
 =?iso-8859-1?Q?3O+ZDdiBMxHEb1kWKW1vYWmiOcbxiLlNR8O1mliOQkqhgx8zNH4wlT/PCr?=
 =?iso-8859-1?Q?/EfubDI98GXaCsoc/0tcvoJrVFht6OaGMR6OtA4R7rEJIEN4zVP/E7zDpp?=
 =?iso-8859-1?Q?TZtdOzSk9Nro/imFn6/D+/+vJNOt5PVTLQlvoVo9jDsQ1RL9BTko0hyFIh?=
 =?iso-8859-1?Q?XJXueAR9m9v6d6YVPPEoaiJ0l7U0dCUqFSXR3svEYOpR2TC9YID3cnAJBV?=
 =?iso-8859-1?Q?nCbfeF62H0Vh2RdgP5KyZH3q+XcWY=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?BJ6dl/IZhD+KIG8BdwcCt1zbc7cX01Niwkc/+WyFQ+9eUSFo8chgiBUil9?=
 =?iso-8859-1?Q?aATSjQVZpjg7OPVLdE87CaHfjI5j214UVEJEfPdueQMI7hCJY/7JoIQCQZ?=
 =?iso-8859-1?Q?ah7ogSTY18Pgg5w+GZ7YPRsBLw/WG3Z9j4fSf+E1zc9Ms8QQM3pHCD5f2J?=
 =?iso-8859-1?Q?04YmSP80jrN4rwzLJW8MR79Uy2u0KoSLNKg3j7/W51JxsJJxZDCRbf7UM8?=
 =?iso-8859-1?Q?OLdDa0hzM4uuEeChKde5ik0gJ260e4x91cU88popOecIe1qHJ/TRbB49h1?=
 =?iso-8859-1?Q?lEyZK7TUx7N2uDoVAlkBjgpUMRoDh85C7XO8Fnyoo7C52vMfqFT4LID5SR?=
 =?iso-8859-1?Q?fBjn2kr0Lu2jC9BwwOIjYFiNaEC02z4VXfph/m2MFRDwjsqgBqF0ymW1IX?=
 =?iso-8859-1?Q?XzHIXbp7Zluqn7H0TgiPA2gCVy8g69DVmZAav/DghqA046PppwfHZ95Asg?=
 =?iso-8859-1?Q?8u1Tx7Xi5tPTOBRBbNEWCTJrMNFxHfLEw+71tyQis8CKyKZm5Znl3++9Fe?=
 =?iso-8859-1?Q?J6+aBmmItuvqZxd3DjQGUojP9BO6XViMa5hUMqo8QT+u+tyC+oolnzoia0?=
 =?iso-8859-1?Q?6hAMDVoScyrImL+HSaxYTcAB5D+U3Zm5BARvv3YoGeoAgXuEfbJLHBkXE/?=
 =?iso-8859-1?Q?S+AMVVmoHLUkBgSyj2DBQOQE90388kXmUUs2HubeCL2J+ZYvg5HpM8bhVc?=
 =?iso-8859-1?Q?s+RTYhUFFvOzRaReyU30V0oGxMsuFUHzpBO90oEBF6/mejlew3ppUR0A6w?=
 =?iso-8859-1?Q?HcRfaP/umKioTrTjUiN3+PyV9yxiLHkCRFqPTWkvlomm8JmzXafxZeK+/D?=
 =?iso-8859-1?Q?JluoSyT9WXPrk7adc8fQ6HF0uUBqr3BPQN9IrWW/+CguKS9GI+RUq06ajf?=
 =?iso-8859-1?Q?K8KqmlsKclQWzsvTCuiKuijCY1R0PIhgNcPXWkNjDm9YezFB6RNSJWq2D7?=
 =?iso-8859-1?Q?kq+IX6PkggBletE64zNnp+Lw7RjYozhdV7S8demSjSgmSowsAVEfsvXhqp?=
 =?iso-8859-1?Q?V//sd/zwe0zhxWUux55WTaeuAB5rVCy5vqtulRNga6giZN8nWKeEy9LLx9?=
 =?iso-8859-1?Q?y4ZaR3Ms1kSP0B1yz2nwhddxpr8xK3t5hbOY8why1elnJ99NPkLyk88T7z?=
 =?iso-8859-1?Q?BXtsdcEPgA4pOh14qnrQTwAzJI4ZBiwo+orL9MGFrOG3cP48OqQcGHgNnp?=
 =?iso-8859-1?Q?FUVUkwO/FXSQ+ZAJcAPFfhR1U4ZGJlke31yAE2uvyv1wE0xsU4BZgEArGx?=
 =?iso-8859-1?Q?dvBA1MMaArklqLsep9EF8s0+8Efeh5WT6yRsu7n7+7z60iCADZke2HxPlI?=
 =?iso-8859-1?Q?tH8FlxeSMy+mSuiFFlUAoMChNza7fyisRU+2SM4cXntaqVOwZke5cr+UO7?=
 =?iso-8859-1?Q?U7mF68TKKyG0sUYjTMzLsCxEogaFcGWg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7818.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 30daa9f9-bc94-49b3-7fdd-08dd76d80807
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2025 20:00:37.6143
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB6726

Hi ,
=A0
Is obtaining the attendee list from MRO Americas 2025 part of your plans?
=A0
Expo Name: =A0MRO Americas - Aviation Week
Total Number of records: 12,000 records=20
List includes: Company Name, Contact Name, Job Title, Mailing Address, Phon=
e, Emails, etc.
=A0
Want to go ahead with these leads? I'll gladly provide the cost.
=A0
Excited for your reply
=A0
Regards
Brenda
Marketing Manager
Prospect Tech Connect.,
=A0
Please reply with REMOVE if you don't wish to receive further emails

